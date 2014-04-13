#!/usr/bin/ruby


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

    @solution = solution_array

# if it's a constant, prune all @solution's but that constant
# if its empty (a zero), prune @solution's by row, prune by column, prune by region

=begin
# first prune the constants
    @solution.each_with_index do |row, y|
      row.each_index do |x|
        if @solution[y][x].count > 1


          @solution[y][x] = @solution[y][x]



        end
      end
    end
=end


# then prune the rows
    @solution.each_with_index do |row, y|
      row.each_with_index do |cell,x|
        if row[x].count > 1
          result = cell - row
        else
          result = cell
        end
        if result == nil
          return nil
        end
        @solution[y][x]=result
      end
    end


# then prune the columns
    @solution.transpose.each_with_index do |row, y|
      @solution[y].each_with_index do |cell, x|
        if cell.count > 1
          result = cell - row
        else
          result = cell
        end
        if result == nil
          return nil
        end
        @solution[y][x]=result
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
              result = cell - regionset
            else
              result = cell
            end
            if result == nil
              return nil
            end
            @solution[region_y*3+y][region_x*3+x] = result
          }
        }
        regionset = Array.new
      }
    }

    @solution


end


  board = Array.new

board[0] = [[7], [0], [9], [3], [0], [0], [0], [0], [0]]
board[1] = [[4], [0], [3], [5], [2], [8], [0], [0], [0]]
board[2] = [[0], [2], [0], [0], [0], [0], [3], [1], [0]]
board[3] = [[1], [0], [5], [6], [7], [9], [0], [0], [0]]
board[4] = [[0], [9], [0], [2], [0], [4], [0], [3], [0]]
board[5] = [[0], [0], [0], [8], [1], [3], [7], [0], [9]]
board[6] = [[0], [8], [2], [0], [0], [0], [0], [9], [0]]
board[7] = [[0], [0], [0], [9], [3], [7], [8], [0], [2]]
board[8] = [[0], [0], [0], [0], [0], [2], [5], [0], [3]]

virgin_board = board

print "\n\nBoard to solve:\n\n"

print print_solution(board)

#create a testable array solution array
#
board.each do |row|
  row.each_index do |index|
    if row[index] == [0]
      row[index] = [1,2,3,4,5,6,7,8,9]
    end
  end
end

partial = board

while partial.flatten.count>81
  partial = solve(board)

  print "\n\npartial:\n\n"
  print_solution(partial)
  puts

if partial == nil
  break
  elseif
  breakout = false
   partial.each do |row|
     row.each_index do |index|
       if row[index].count > 1
         row[index] = row[index][0]
         breakout = true
         break
       end
       if breakout == true
         break
        end
      end
end
end

end

print "\n\n We have a final Solution:\n\n"
print print_solution(solution)