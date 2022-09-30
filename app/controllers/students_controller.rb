class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    # GET/ students
    def index 
        students = Student.all 
        render json: students
    end

    # GET /students/:id
    def show
        student = find_student
        render json: student
    end

    # POST /students
    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    # PATCH/students/:id
    def update 
        student = find_student
        student.update!(student_params)
        render json: student
    end


    # DELETE/ students/:id 
    def destroy
        student = find_student
        student.destroy
        render json: { error: "Student not found"}, status: :not_found
    end

    private 

    def student_params
        params.permit(:name, :mojor, :age, :instructor_id)
    end

    def find_student
        Student.find_by(params[:id]) 
    end
    
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end

