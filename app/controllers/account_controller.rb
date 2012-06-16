class AccountController < ApplicationController

	before_filter :authenticate_user!, :except=>[:list_group]

  def new_group
		@group = Group.new

#		respond_to do |format|
#			format.html # new_group.html.erb
#			format.xml { render :xml => @group }
#		end
  end

	def create_group
		if current_user[:group_id] != nil
			  flash[:notice] = 'You can create group only one.'
        redirect_to( :action => 'list_group')
		else
			@group = Group.new(params[:group])

				if @group.save
					current_user[:group_id] = @group.id					#CHECK
					current_user.update_attributes(:group_id)   #CHECK
					flash[:notice] = 'Group was successfully created.'
					redirect_to( :action => 'list_group')
				else
					format.html { render :action => "new"}
				end
		end

#		render :text => "#{current_user[:group_id]}"

	end

	def list_group

		@groups = Group.order('name DESC').page(params[:page]).per(5)

	end

	def edit_group
		@group = Group.find(params[:id])
	end

	def update_group
		@group = Group.find(params[:id])
		if @group.update_attributes(params[:group])
			flash[:notice] = 'Group was succesfully updated.'
			redirect_to(:action => 'list_group')
		else
			render(:action => 'edit_group')
		end
	end

	def destroy_group
		Group.find(params[:id]).destroy
		current_user[:group_id] = nil				
		current_user.update_attributes(:group_id) 
		redirect_to(:action => 'list_group')
	end

  def list_member
    @group = Group.find(params[:id])
#		@users = User.order('name DESC').page (params[:page]).per(5)
		@members = Member.find(:all, :conditions => ['group_id = ?', @group.id] )
  end

  def new_member
#		@group = Group.find(:all, :conditions => ['group_id = ?', @group_id] )
#		render :text => "#{@group_id}"
    @member = Member.new
    @groups = Group.find(:all)
  end
  
  def create_member
    @member = Member.new(params[:member])
		@member[:user_id] = current_user.id

      if @member.save
        flash[:notice] = 'Member was successfully created.'
        redirect_to( :action => 'list_member', :id => @member.group)
      else
        @member = Group.find(:all)
        render :action => "new_member"
      end
  end
  
  def edit_member
    @member = Member.find(params[:id])
    @groups = Group.find(:all)
  end

  def update_member
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:notice] = 'Member was succesfully updated.'
      redirect_to(:action => 'list_member', :id => @user.member_id)
    else
      @member = Member.find(:all)
      render(:action => 'edit_member')
    end
  end

  def destroy_member
    member = Member.find(params[:id])
    group_id = member.group_id
    member.destroy
    redirect_to(:action => 'list_group', :id => group_id)
  end

end
