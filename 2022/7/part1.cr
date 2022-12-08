MAX_SIZE = 100000

class Directory
    getter(name)
    getter(parent)
    getter(children)

    def initialize(@name : String, @parent : Directory?)
        @children = [] of (Directory | FileObj)
    end

    def add_child(child : (Directory | FileObj))
        @children.push(child)
    end

    def size
        sizes = @children.map { |c| c.size }
        sizes.reduce { |acc, x| acc+x }
    end
end

class FileObj
    getter(name)
    getter(size)
    getter(parent)

    def initialize(@name : String, @size : Int32, @parent : Directory)
    end
end

input = File.read("part1.input")

root = Directory.new("/", nil)
cwd: Directory = root

input.split("\n").each do |line|
    if line.starts_with? "$"
        # Command
        _, command, *argument = line.split(" ")

        if command == "cd"
            if argument[0] == "/"
                cwd = root
            elsif argument[0] == ".."
                unless cwd.parent.nil?
                    cwd = cwd.parent.not_nil!
                else
                    raise "Already at root dir"
                end
            else
                dir = Directory.new(argument[0], cwd)
                cwd.add_child(dir)
                cwd = dir
            end
        end
    else
        size, name = line.split(" ")
        size = size.to_i?
        if size
            cwd.add_child(FileObj.new(name, size, cwd))
        end
    end
end

def find_right_sized_directories(dir : Directory)
    dirs = [] of Directory
    if dir.size <= MAX_SIZE
        dirs.push(dir)
    end

    dir.children.each do |d|
        if d.is_a? Directory
            dirs += find_right_sized_directories(d)
        end
    end

    return dirs
end

puts find_right_sized_directories(root).reduce(0) { |acc, d| acc + d.size }