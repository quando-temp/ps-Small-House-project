module Spina
  module Admin
    class StudentsController < AdminController

      before_action :set_student, only: [:edit, :update, :destroy, :favorite_student, :delete_favorite_student]

      layout 'spina/admin/admin'

      def index
        @students = Student.all
        @favor_students = Student.where(favorite: true)
      end

      def new
        @student = Student.new
        @courses = Course.all.try(:map) {|x| [x.name + ' (' +x.code + ')', x.id]}.unshift(['không có', nil])
      end

      def edit
        @courses = Course.all.try(:map) {|x| [x.name + ' (' +x.code + ')', x.id]}.unshift(['không có', nil])
      end

      def create
        @student = Student.new(student_params)
        if @student.save
          redirect_to admin_students_path, notice: 'student was successfully created.'
        else
          render :new
        end
      end

      def update
        if @student.update(student_params)
          redirect_to admin_students_path, notice: 'student was successfully updated.'
        else
          render :edit
        end
      end

      def destroy
        if @student.destroy
          redirect_to admin_students_path, notice: 'Student was successfully destroyed.'
        end
      end

      def favorite_student
        if @student.update_attribute(:favorite, true)
          redirect_to admin_students_path, notice: 'student was successfully updated.'
        else
          render :edit
        end
      end

      def delete_favorite_student
        if @student.update_attribute(:favorite, false)
          redirect_to admin_students_path, notice: 'student was successfully updated.'
        else
          render :edit
        end
      end

      private
      def student_params
        params.require(:student).permit(:name, :course_id, :description, :start_date, :birthday, :phone, :home, :parent, :end_date, :avatar)
      end

      def set_student
        @student = Student.find(params[:id])
      end
    end
  end
end