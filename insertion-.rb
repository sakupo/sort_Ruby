############
# 挿入ソート #
############

# グローバル変数 
#  $n ：データ個数
#  $d[1],...,$d[$n] ：データ（整数）を入れる。
#  $d[0] は原則使用しないが、番兵を使う挿入ソートプログラム用に空けておく。
#  $step ：比較回数

#####
# キーボードからデータを入力する手続き
#####

def keyboard_in()
  for i in 1..$n
    $d[i] = STDIN.gets().to_i  # ARGVとgetsを併用する場合には STDIN が必要
  end
end

#####
# 画面にデータを出力する手続き
#####

def display_out()
  for i in 1..$n
    puts($d[i])
  end
  print("\n")
end


#####
# 乱数データを作る手続き
#####

def random_in()
  for i in 1..$n
    $d[i] = rand($n)  # 0から$n-1 までの乱数
  end
  print("長さ", $n, "の乱数列を生成しました。\n")
end

#####
# 正順データを作る手続き
#####

def sorted_in()
  for i in 1..$n
    $d[i] = i
  end
  print("長さ", $n, "の正順列を生成しました。\n")
end

#####
# 逆順データを作る手続き
#####

def rev_sorted_in()
  for i in 1..$n
    $d[i] = $n-i
  end
  print("長さ", $n, "の逆順列を生成しました。\n")
end


#####
# $d[1]..$d[$n]が整列していたら1，整列していなかったら0を返す関数
#####

def check()
  for i in 1..($n-1)
    if $d[i] > $d[i+1]
      return 0;
    end
  end
  return 1
end


#####
# $d[x]と$d[y]を交換する手続き
#####

def swap(x, y)
  temp = $d[x]
  $d[x] = $d[y]
  $d[y] = temp
end


#####
# $d[1]...d[$n]を挿入ソートする手続き
#####

def insertion_sort()
  for i in 2..$n
    j = i
    while j >= 2
      $step = $step + 1
      if $d[j-1] > $d[j]
        swap(j-1, j)
      else
        break      # while文から強制的に抜け出る
      end
      j = j - 1
    end
  end
end

#####
# 以下は$d[0]を番兵として使用した効率の良いプログラム。
# swapを使わず代入回数が減る。
# ただし番兵との比較もカウントするので比較回数は少し増える。
#####

def kashikoi_insertion_sort()
  for i in 2..$n
    j = i
    $d[0] = $d[i]
    $step = $step + 1
    while $d[j-1] > $d[0]
      $step = $step + 1
      $d[j] = $d[j-1]
      j = j - 1
    end
    $d[j] = $d[0]
  end
end


#####
# 本体
#####

$n = ARGV[0].to_i      # 実行時コマンドライン引数を$nに整数として取り込む。
$d = Array.new($n+1)   # 長さ($n+1)の配列 $d[0],$d[1],...,$d[$n] を用意する。
                       # データは $d[1]以降に入れる。
$step = 0



####################################
#以下はデータの生成
#使いたい作成手続きを残して他はコメントアウトする。

#random_in()      # 乱数データ
#sorted_in()      # 正順データ
rev_sorted_in()  # 逆順データ

#データ作成終了
######################################

print("挿入ソートを実行します。\n")
insertion_sort()
if check()==1
  print("整列しました。比較回数は ", $step, " 回でした。\n")
else
  print("！！整列していません！！\n")
end
