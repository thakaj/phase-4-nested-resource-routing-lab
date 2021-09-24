class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
    items = Item.all
    end
    render json: items, except: [:created_at, :updated_at], include: :user, except: [:created_at, :updated_at]
  end
  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items.find(params[:id])
    else
      items = Item.find(params[:id])
    end
    render json: items, include: :user, except: [:created_at, :updated_at]
  end
  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items.create!(name: params[:name], description: params[:description], price: params[:price])
    else
      items = Item.create!(name: params[:name], description: params[:description], price: params[:price])
    end
    render json: items, include: :user, except: [:created_at, :updated_at], status: 201
  end
  private
  def render_not_found
    render json: {errors: "Not found"}, status: 404
  end
end
