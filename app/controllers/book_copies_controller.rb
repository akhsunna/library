# Controller for book copies
class BookCopiesController < ApplicationController
  def delete
    @book_copy = BookCopy.find(params[:book_copy_id])
    @book = @book_copy.book
  end

  def destroy
    @book_copies = BookCopy.all
    @book_copy = BookCopy.find(params[:id])
    @book = @book_copy.book
    @book_copy.destroy
  end

  # handle_asynchronously :reminder_email, run_at: Proc.new { when_to_run }


end
