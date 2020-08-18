require "csv"

module StudentServices
  class ExportCsv
    STUDENT_CSV_COLUMNS = %w[
      1
      2
      3
      4
    ]
    def initialize(students)
      @students = students.includes(:fp_user).order(id: :desc)
    end

    def execute
      CSV.generate do |csv|
        csv << STUDENT_CSV_COLUMNS
        @students.each do |student|
          csv << row
        end
      end
    end
  end
end
