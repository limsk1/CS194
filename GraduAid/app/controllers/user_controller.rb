class UserController < ApplicationController
  before_filter :already_login  
  skip_before_filter :already_login, :only => [:logout, :profile, :post_track, :post_photo, :delete_account, :like, :dislike]
  skip_before_filter :verify_authenticity_token, :only => [:post_track, :delete_account, :like, :dislike]

  def already_login
    if session[:curr_id] then
      redirect_to "/main/index"
    end
  end

  def login
  end

  def post_login  
    @user = User.find_by_email(params[:email])
    if @user and @user.password_valid?(params[:password]) then
      session[:curr_id] = @user.id 
      redirect_to "/main/index"
    else
      redirect_to "/", :alert => "Wrong username or password."
    end
  end

  def logout
    reset_session
    redirect_to "/", :notice => "Logged out successfully."
  end

  def register
    @user = User.new
  end

  def post_register
    @user = User.new(user_params)
    flag = ((params[:user][:password] == params[:user][:password_confirmation]) and (params[:user][:password].length > 7))

    if @user.valid? and @user.email_valid?(@user.email) and flag then
      @user.save!

      ap_list = ['AP Calc AB', 'AP Calc BC', 'AP Chem', 'AP Phys B', 'AP Phys C Mech', 'AP Phys C E&M']
      ap_list.each do |ap_credit_name|
        ap_credit = ApCredit.new(name: ap_credit_name, grade: 0)
        ap_credit.user = @user
        ap_credit.save!
      end

      session[:curr_id] = @user.id
      redirect_to "/main/index", :notice => "Welcome! Set your track and add courses in here!", :alert => "Welcome! Go to your profile to update your courses!"
    else
      if not @user.email_valid?(@user.email) then
        @user.errors.add(:email, "is not Stanford email")
      end

      if not flag then
        @user.errors.add(:password, "too short or not matched with confirmation")
      end

      render(:action => :register)
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_digest, :salt)
  end

  def post_track
    track_id = params[:track_id]
    @user = User.find(session[:curr_id])
    if @user != nil then
      @user.track = Track.find_by(id: track_id)
      @user.save!
      render :text => "Track updated!" + "," + @user.track.name
    end
  end

  def profile
    @user = User.find(session[:curr_id])
    @takens = Taken.where(user_id: @user.id)
    url = "http://explorecourses.stanford.edu/?view=xml-20140630&academicYear=20152016"
    doc = Nokogiri::HTML(open(url))
    dept_set = doc.xpath("//department")
    @dept_list = []
    dept_set.each do |dept|
        @dept_list << dept['name']
    end
    @dept_list.sort!
  end

  def post_photo
    uploaded = params[:photo]
    puts uploaded.original_filename
    @user = User.find(session[:curr_id])

    if uploaded then
      dir = "#{Rails.root}/app/assets/images/" + @user.id.to_s
      Dir.mkdir(dir) unless File.exists?(dir)
      file = File.new(Rails.root.join('app', 'assets', 'images', @user.id.to_s, uploaded.original_filename), 'wb')
      file.write(uploaded.read)
      file.close

      @user.profile_file_path = @user.id.to_s + "/" + uploaded.original_filename
      @user.save!
    end

    redirect_to "/user/profile"
  end

  def delete_account
    user = User.find(session[:curr_id])
    user.destroy
    Taken.where(user_id: user.id).destroy_all
    reset_session
    redirect_to "/", :notice => "Succssfully deleted the account."
  end

  def like
    user = User.find_by(id: session[:curr_id])
    like = Like.find_by(user_id: user.id, course_id:params[:course_id])
    
    if params[:enable] then
      if not like then
        like = Like.new
        like.user_id = user.id
        like.course_id = params[:course_id]
        like.save!
      end

      like.up = true
      like.save!
    else
      if like then
        like.destroy
      end
    end

    redirect_to request.referer
  end

  def dislike
    user = User.find_by(id: session[:curr_id])
    like = Like.find_by(user_id: user.id, course_id:params[:course_dis_id])

    if params[:enable] then
      if not like then
        like = Like.new
        like.user_id = user.id
        like.course_id = params[:course_dis_id]
        like.save!
      end

      like.up = false
      like.save!
    else
      if like then
        like.destroy
      end
    end

    redirect_to request.referer
  end
end
