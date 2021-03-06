# 使い方
# ruby expand_du.rb パス
# 例：ruby expand_du.rb ~
#
# 効果
# - パスに対してduコマンドを実行
# - 実行結果を標準出力とファイルに吐き出す
#
# 引数
# - パス: duコマンドを行う対象パス

require 'rbconfig'

def main(target_path)
  return puts "ArgumentError: パスを引数に入れてください" if target_path.nil?

  max_depth_option_str = if os == :macosx
    "-d"
  else
    "--max-depth"
  end

  exec_command = "du -k #{max_depth_option_str} 1 #{target_path}"
  du_result_str = `#{exec_command}`

  return if du_result_str.empty?

  output_disksizes(du_result_str, exec_command)
end

def output_disksizes(du_result_str, exec_command)
  disk_usages = du_result_str
                  .split("\n")
                  .map{|du_result| DiskUsage.new(du_result)}
                  .sort{|x, y| x.size <=> y.size}.reverse

  output_filename = "#{exec_command.gsub(/( |\/){1,}/, "_")}_#{Time.new.strftime("%Y%m%d%H%M%S")}.log"
  output_file = File.open(output_filename, "w")

  disk_usages.each do |disk_usage|
    puts disk_usage.to_s
    output_file.puts(disk_usage.to_s)
  end

  output_file.close
  puts "#{output_filename}に保存しました"
end

class DiskUsage
  attr_reader :size, :path
  def initialize(du_result_line)
    du_result_params = du_result_line.split(" ").map(&:strip)
    @size = du_result_params[0].to_i
    @humanreadable_size, @humanreadable_unit = calc_humanreadable_size
    @path = du_result_params[1]
  end

  def to_s
    # NOTE とりあえず5桁を指定。必要になったら増やす
    "#{sprintf("%5d" % @humanreadable_size)}#{@humanreadable_unit} #{@path}"
  end

  def humanreadable_size_with_unit
    "#{@humanreadable_size}#{@humanreadable_unit}"
  end

  private

  def calc_humanreadable_size
    return [@size, "KB"] if mb_size < 1
    return [mb_size, "MB"] if gb_size < 1
    return [gb_size, "GB"] if tb_size < 1
    [tb_size, "TB"]
  end

  def kb_size
    @size
  end

  def mb_size
    kb_size.fdiv(1024).round(1)
  end

  def gb_size
    mb_size.fdiv(1024).round(1)
  end

  def tb_size
    gb_size.fdiv(1024).round(1)
  end
end

def os
  case RbConfig::CONFIG['host_os']
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    :windows
  when /darwin|mac os/
    :macosx
  when /linux/
    :linux
  when /solaris|bsd/
    :unix
  else
    :unknown
  end
end

# TODO 以下を実現できるオプション引数を入れる
# - 足切りファイルサイズ。1G以上とか。数字だけ入れたらバイト計算。文字なら単位を読み取り単位でフィルタリング
# - 出力行数を指定。標準出力、ファイル出力両方
# - 結果をファイル出力する
# - du用のオプション(dなど)をデフォルト値とセットでラッピング

main(ARGV[0])


