
module BioTable

  module Statistics

begin
  require 'statsample'
rescue LoadError
  $stderr.print "Error: Missing statsample. Install with command 'gem install statsample'\n"
  exit 1
end

    attr_reader :columns

    class Accumulate

      def initialize
        @columns = []
      end

      def add row, type
        if type == :header
          @header = row
        else
          row.each_with_index do | e,i |
            @columns[i] = [] if not @columns[i]
            @columns[i] << e.to_f
          end
        end
      end

      def write writer
        vectors = @columns.map { |c| c.to_scale }

        writer.write(TableRow.new("stat",@header),:header)
        
        sizes = @columns.map { |c| c.size }
        writer.write(TableRow.new("size",sizes),:row)
        writer.write(TableRow.new("min",vectors.map { |v| v.min }),:row)
        writer.write(TableRow.new("max",vectors.map { |v| v.max }),:row)
        writer.write(TableRow.new("median",vectors.map { |v| v.median }),:row)
        writer.write(TableRow.new("mean",vectors.map { |v| v.mean }),:row)
        writer.write(TableRow.new("sd",vectors.map { |v| v.sd }),:row)
        writer.write(TableRow.new("cv",vectors.map { |v| v.coefficient_of_variation }),:row)
      end

    end
  end

end
