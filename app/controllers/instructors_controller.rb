class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    # GET/ instructors
    def index 
        instructors = Instructor.all 
        render json: instructors
    end

    # GET /Instructors/:id
    def show
        instructor = find_instructor
        render json: instructor
    end

    # POST /instructors
    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    # PATCH/instructors/:id
    def update 
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor, status: :updated
    end


    # DELETE/ instructors/:id 
    def destroy
        instructor = find_instructor
        instructor.destroy
        render json: { error: "Instructor not found"}, status: :not_found
    end

    private 

    def instructor_params
        params.permit(:name)
    end

    def find_instructor
        Instructor.find_by(params[:id]) 
    end
    
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end

