class ProjectController < ApplicationController
  before_action :authenticate_user!, only: [:list]
  # before_action :payment_user, only: [:show]
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    session[:project_id] = @project.id
    @tasks = @project.tasks.order(:tag)
    @joined = false
    if current_user.present? && current_user.projects.present?
      @joined = current_user.projects.include?(@project)
    end
    @users = @project.users.order('created_at desc').first(10)
    @review = Review.new
    @reviews = @project.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def list
    @projects = current_user.projects.with_deleted.uniq unless current_user.nil?
    if current_user.payments.blank? || current_user.payments.last.try(:status) == 1
      @projects = @projects.where(free_flg: 1).uniq
    end
  end

  private
  def payment_user
    unless current_user.payments.last.try(:status) == "availability"
      flash.notice = "課金してね"
      redirect_to root_path
    end
  end
end
