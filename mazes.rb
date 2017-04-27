class Maze

  attr_reader :maze , :previous_step

  def initialize(maze = "maze1.txt")
    @maze = (File.readlines(maze)).map{|line| line.chars}
    @previous_step = "S"
  end

  #
  # def [](pos)
  #   row, col = pos
  #   maze[row][col]
  # end
  #
  # def []=(pos, val)
  #   row, col = pos
  #   maze[row][col] = val
  # end

  def display
    find_route
    quickest_route

    puts "THIS IS THE FASTET ROUTE!"
    puts remove_numbers
    #puts maze.join("   ")


  end

  def remove_numbers
    maze2 = []
    maze.each do |line|
      line.each  do |char|

          char = " " if char.to_i != 0
          maze2 << char

      end
    end
   maze2.join
  end

  def all_around(char)
    maze.each_index do |i|
        maze[i].each_index do |j|
         if maze[i][j] == char
            ##set last move to >
            if maze[i-1][j] != " " && maze[i+1][j] != " " && maze[i][j+1] != " " && maze[i][j-1] != " "

              if maze[i][j-1] == previous_step.to_s
                maze[i][j-1] = ">"
              elsif maze[i][j+1] == previous_step.to_s
              maze[i][j+1] = ">"
            elsif maze[i+1][j] == previous_step.to_s
              maze[i+1][j] == ">"
            elsif maze[i-1][j] == previous_step.to_s

              maze[i-1][j] == ">"
              end
              #stops the take step loop
              return true

            end
           end
         end
        end


    false
   end


  def  find_route

    #place_step(maze , previous_step)
    until all_around("E")
    place_step(maze , @previous_step.to_s)

   end

    def quickest_route

        index = previous_step

        while index > 0
          maze.each_index do |i|
            maze[i].each_index do |j|
              if maze[i][j] == ">"
                    #left
                    if maze[i][j-1].to_i == index
                   maze[i][j-1] = ">"
                   #down
                 elsif maze[i+1][j].to_i == index
                   maze[i+1][j] = ">"
                  # UP
                elsif maze[i-1][j].to_i == index
                  maze[i-1][j] = ">"
                  #right
                elsif  maze[i][j+1].to_i == index
                   maze[i][j+1] = ">"
                end
               end
            end
          end
          index -= 1
        end
      end
  end



  def place_step (maze , prevous_step )

      maze.each.with_index do |line , j|
        line.each_index do | idx |
          if line[idx - 1] == prevous_step
            #down
            maze[j - 1][idx-1] = (prevous_step.to_i + 1).to_s if maze[j - 1][idx-1] == " "
            #up
            maze[j + 1][idx-1] = (prevous_step.to_i + 1).to_s if maze[j + 1][idx-1] == " "
            #left
            line[idx  ] = (prevous_step.to_i + 1).to_s if line[idx  ] == " "
            #right
            line[idx - 2 ] = (prevous_step.to_i + 1).to_s if line[idx - 2  ] == " "
            @previous_step = prevous_step.to_i + 1
            #previous_step =  prevous_step.to_i + 1 if line[idx  ] == prevous_step.to_i  + 1
          else

          end
        end
      end
  end

end


if __FILE__ == $PROGRAM_NAME

maze = Maze.new
maze.display

end
