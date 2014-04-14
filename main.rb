
  def print_solution(a_solution)
    a_solution.each_with_index do |row, y|
      printf 'row: %d: ', y
      row.each_index do |x|
        printf '%s ', a_solution[y][x]
      end
      puts
    end
    puts
  end


  def solve(solution_array)

    # in comes a partial solution array
    # the algorithm fixes the first one and computes the possibles.

    #out goes a pruned array for recursive reinjection or
    #a nil

    @solution = Marshal.load( Marshal.dump( solution_array ))
    #@original = Marshal.load( Marshal.dump( solution_array ))

# then prune the rows
    @solution.each_with_index do |row, y|
      row.each_index do |x|
        @result = row[x]
        if row[x] == [0]
           @result = [1,2,3,4,5,6,7,8,9] - $board[y].flatten
        end
        if row[x].count > 1
          @result = row[x] -  $board[y].flatten
        end
        if @result == nil
          return nil
        end
        @solution[y][x]= @result
      end
    end


# then prune the columns
    @solution.transpose.each_with_index do |row, y|
      row.each_index do |x|
        @result = row[x]
        if row[x].count > 1
          @result = row[x] -  $board[y].flatten
        end
        if @result == nil
          return nil
        end
        @solution[y][x]=@result
      end
    end


    regionset = Array.new

#then prune by region
    (0..2).each { |region_y|
      (0..2).each { |region_x|
        (0..2).each { |y|
          (0..2).each { |x|
            regionset.push(@solution[region_y*3+y][region_x*3+x])
          }
        }
        (0..2).each { |y|
          (0..2).each { |x|
            cell = @solution[region_y*3+y][region_x*3+x]
            if cell.count > 1
              @result = cell - regionset
            else
              @result = cell
            end
            if @result == nil
              return nil
            end
            @solution[region_y*3+y][region_x*3+x] = @result
          }
        }
        regionset = Array.new
      }
    }

    return @solution
end


  def pick_one(partial)
    breakout = false
    partial.each_with_index  do |row, y|
      row.each_index do |index|
        if row[index].count > 1
          $board[y][index] = [row[index][0]]
          partial[y][index] = [row[index][0]]
          breakout = true
          break
        end
        if breakout == true
          break
        end
      end
      if breakout == true
        break
      end
    end
  end


$board = Array.new
virgin_board = Array.new
partial = Array.new

$board[0] = [[7], [0], [9], [3], [0], [0], [0], [0], [0]]
$board[1] = [[4], [0], [3], [5], [2], [8], [0], [0], [0]]
$board[2] = [[0], [2], [0], [0], [0], [0], [3], [1], [0]]
$board[3] = [[1], [0], [5], [6], [7], [9], [0], [0], [0]]
$board[4] = [[0], [9], [0], [2], [0], [4], [0], [3], [0]]
$board[5] = [[0], [0], [0], [8], [1], [3], [7], [0], [9]]
$board[6] = [[0], [8], [2], [0], [0], [0], [0], [9], [0]]
$board[7] = [[0], [0], [0], [9], [3], [7], [8], [0], [2]]
$board[8] = [[0], [0], [0], [0], [0], [2], [5], [0], [3]]


virgin_board = Marshal.load( Marshal.dump( $board ) )
print "\n\n$board to solve:\n\n"
print print_solution($board)


partial = Marshal.load( Marshal.dump( (solve($board))) )

while partial.flatten.count>81
  pick_one(partial)
  partial =  solve(partial)

  print "\n\npartial:\n\n"
  print_solution(partial)
  puts

end

print "\n\n We have a final Solution:\n\n"
print print_solution(partial)