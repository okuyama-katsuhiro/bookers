class BooksController < ApplicationController
  require './app/models/book.rb'
# BooksControllerの定義

  def top
@books = Book.all
@book = Book.new
end

def new
@book = Book.new
end

def create
  @book = Book.new(book_params)

  if @book.valid?
    @book.save
    redirect_to @book, notice: 'Book was successfully created.'
  else
    flash.now[:alert] = @book.errors.full_messages.join(', ')
    @books = Book.all
    render :top
  end
end

def index
@books = Book.all
end

def show
@book = Book.find(params[:id])
end

def edit
@book = Book.find(params[:id])
end

def update
@book = Book.find(params[:id])

if @book.update(book_params)
redirect_to @book, notice: 'Book was successfully updated.'
else
flash.now[:alert] = @book.errors.full_messages.join(', ')
render 'edit'
end
end

def destroy
@book = Book.find(params[:id])
@book.destroy
redirect_to books_path
end

private

def book_params
params.require(:book).permit(:title, :body)
end
end