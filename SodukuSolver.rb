#
# Soduku Solver
#
#


#
#  Initialize Data Structures
#
rows, cols = 9,9
board = Array.new(rows) { Array.new(cols)  }

couldbe = Array.new(rows) { Array.new(cols) }

couldbe.each_with_index do |row, y|
  row.each_index do |x|
  couldbe[y][x] = [1,2,3,4,5,6,7,8,9]
  end
#  print board[y]
end

#puts board.flatten.count
#puts couldbe.flatten.count

#
#  Enter Puzzle
#

board[0] = [7,0,9,3,0,0,0,0,0]
board[1] = [4,0,3,5,2,8,0,0,0]
board[2] = [0,2,0,0,0,0,3,1,0]
board[3] = [1,0,5,6,7,9,0,0,0]
board[4] = [0,9,0,2,0,4,0,3,0]
board[5] = [0,0,0,8,1,3,7,0,9]
board[6] = [0,8,2,0,0,0,0,9,0]
board[7] = [0,0,0,9,3,7,8,0,2]
board[8] = [0,0,0,0,0,2,5,0,3]

board.each_with_index do |row, y|
  print board[y].inspect
  puts
end

#
# Solve Puzzle
#

# No duplicates in a column
# No duplicates in a row
# No duplicates in a region

# 1st pass
# brute force
#

# define "could be" array for each cell
# populate couldBe's with 1..9
# if it's a constant, prune all couldbe's but that constant
# if its empty (a zero), prune couldbe's by row, prune by column, prune by region


# first prune the constants
couldbe.each_with_index do |row, y|
  #printf "row: %d: ", y
  row.each_index do |x|
    if board[y][x] != 0
      couldbe[y][x] = [board[y][x]]
    end
    #print couldbe[y][x]
  end
  #puts
end

# then prune the rows
board.each_with_index do |row, y|
  couldbe[y].each_with_index do |cell, x|
    #print "row:",y," col:",x," "
    if cell.count > 1
     result = cell - row
    else
      result = cell
    end
    couldbe[y][x]=result
    #print couldbe[y][x]
    #puts
  end
  #puts
end


# then prune the columns
board.transpose.each_with_index do |row, y|
  #print "row:", y , " " , row
  couldbe.transpose[y].each_with_index do |cell, x|
    #print "row:",x," col:",y,":"

    if cell.count > 1
      result = cell - row
    else
      result = cell
    end
    #print cell, " - ", row, " = " , result
    couldbe[y][x]=result
    #print couldbe[y][x]
    #puts
  end
  #puts
end

puts
regionset = Array.new
couldbeset = Array.new
#then prune by region
for region_y in 0..2
 for region_x in 0..2
   for y in 0..2
     for x in 0..2
   regionset.push(board[region_y*3+y][region_x*3+x])
  # print region_y," ", region_x, " ", board[region_y*3][region_x*3]
     end
   end
   print regionset
   puts
   for y in 0..2
     for x in 0..2
       cell = couldbe[region_y*3+y][region_x*3+x]
       if cell.count > 1
         result = cell - regionset
       else
         result = cell
       end
       print cell, " - ", regionset, " = " , result
       couldbe[region_y*3+y][region_x*3+x] = result
       #print couldbe[y][x]
       puts
     end
     puts
   end
   regionset = Array.new

  end
end

#
# Output Solution
#


puts
puts
couldbe.each_with_index do |row, y|
  printf "row: %d: ", y
  puts
  row.each_index do |x|
    printf "%s\n" ,couldbe[y][x]
  end
  puts
end


