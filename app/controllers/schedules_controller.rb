class SchedulesController < ApplicationController

	before_filter :authenticate_user!, :except=>[ :month ]

	FILE_PATH = "#{Rails.root.to_s}/files/#{ENV['RAILS_ENV']}"
  # GET /schedules
  # GET /schedules.xml

  def index

			@schedules = Schedule.where('user_id = ? or group_id = ?', current_user[:id], current_user[:group_id] ).
														order('datetime DESC').page(params[:page]).per(5)

# render :text => "#{Schedule.class}" #for debug


#    respond_to do |format|
#      format.html # index.html.erb
#      format.json  { render :json => @schedules }
#    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
		@schedule = Schedule.find(params[:id])
		@all = Schedule.find(:all, :order => 'datetime DESC')
#   respond_to do |format|
#   format.html # show.html.erb
#   format.xml  { render :xml => @schedule }
#   end
  end

  # GET /schedules/new
  # GET /schedules/new.xml
  def new
    @schedule = Schedule.new
      if params[:date]
        @schedule.datetime = Time.parse(params[:date]) rescue nil
      end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    find_schedule
  end

  # POST /schedules
  # POST /schedules.xml
  def create
		set_file_name
    @schedule = Schedule.new(params[:schedule])
		@schedule[:group_id] = current_user.group_id
		@schedule[:user_id] = current_user.id
    respond_to do |format|
      if @schedule.save
				save_file
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully created.') }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update
		set_file_name
    find_schedule

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
				save_file
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy
    find_schedule
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def month
    @year = params[:year] ? params[:year].to_i : Time.now.year
#render :text => "#{@month_next}" #デバック用
    @month = params[:month] ? params[:month].to_i : Time.now.month
    unless Date.valid_date?(@year, @month, 1)
      @year = Time.now.year
      @month = Time.now.month
    end
    @this = DateTime.new(@year, @month, 1, 0, 0, 0, '+09:00')
#render :text => "#{@this}"
    @prev = (@this << 1)
    @next = (@this >> 1)
    @schedules = Hash.new{|hash, key| hash[key] = []}
		if current_user
#	    Schedule.where('user_id = ? or group_id = ?', current_user[:id], current_user[:group_id] ).find(:all, :conditions => ['datetime >= ? And datetime < ? ',@this, @next]).each do |schedule|

			Schedule.where('user_id = ? or group_id = ?', current_user[:id], current_user[:group_id] ).find(:all).each do |schedule|
#render :text => "#{@this}"
#break
				if schedule.datetime.to_datetime >= @this  and schedule.datetime.to_datetime < @next
	      	date = Date.new(schedule.datetime.year,
                      schedule.datetime.month,
                      schedule.datetime.day)
	      	@schedules[date] << schedule
				end
			end
		end
  end
  
	def view_file
		find_schedule
		file = "#{FILE_PATH}/#{@schedule.id}"
		send_file(file, :filename => @schedule.file_name, :stream => false, :disposition => 'inline')
	end

	def search
		schedules = Schedule.find(:all,
															#:include => [:user],
															#:conditions => ['users.group_id = ?', session[:user].group_id],
															:order => 'datetime DESC')
		regexp = Regexp.new(params[:schedule][:title], true)
		@results = schedules.select do |schedule|
			regexp =~ schedule.title || regexp =~ schedule.content
		end
		if @results.empty?
#			redirect_to (:month_schedules, :notice => '見つかりません。')
			render(:partial => 'not_found')
		else
#			redirect_to :action => 'show',:id => @results
			render(:partial => 'found')
		end
	end

	private

	def find_schedule
		@schedule = Schedule.find(params[:id])
	end

	def set_file_name
		@file = params[:schedule][:file_name]
		params[:schedule][:file_name] = @file.original_filename if @file
	end

	def save_file
		if @file
			File.open("#{FILE_PATH}/#{@schedule.id}", "wb") do |f|
				f.write(@file.read)
			end
		end
	end
end
