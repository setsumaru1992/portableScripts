require "csv"

$is_debug = true

def main(csv)
  # output_file_writer = CSV.open(output_file, "w")
  # output_cols = ["hoge"]
  # output_file_writer.puts(output_cols)

  FileHandler.csv_foreach(csv) do |row|
    # 処理
    p row

    # output_row_values = []
    # output_file_writer.puts(output_row_values)
  end

  # puts "#{output_file}を作成しました"
  # output_file_writer.close
end

module FileHandler
  class << self
    def csv_foreach(csv)
      log "#{Time.now}: read start #{csv}"
      all_line_count = line_count(csv)

      return_values = CSV.foreach(csv, headers: true).with_index(1).map do |row, row_no|
        log progress(row_no, all_line_count) if progress_timing?(all_line_count, row_no)
        yield(row)
      end

      log "#{Time.now}: read end #{csv}"

      return_values
    end

    def line_count(file)
      open(file){|f|
        while f.gets; end
        f.lineno
      }
    end

    private

    def log(message)
      puts(message) if $is_debug
    end

    def progress_timing?(all_line_count, line_no)
      return false if all_line_count < 100

      # NOTE 処理時間によって変更
      div_number = 100

      percent_unit = all_line_count / div_number
      line_no % percent_unit == 0
    end

    def progress(current_count, all_count)
      "#{Time.now}: #{CommonUtilities.percent(current_count, all_count)}% (#{CommonUtilities.number_with_commma(current_count)} / #{CommonUtilities.number_with_commma(all_count)})"
    end
  end
end

module CommonUtilities
  class << self
    def percent(num, all_count)
      (num.fdiv(all_count) * 100).round(2)
    end

    def number_with_commma(number)
      number.to_s.gsub(/(\d)(?=\d{3}+$)/, '\\1,')
    end
  end
end

main(ARGV[0])