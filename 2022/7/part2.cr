TOTAL_SPACE = 70000000
DESIRED_SPACE = 30000000

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

def get_dirs_recursively(dir : Directory)
    dirs = [] of Directory
    dirs.push(dir)

    dir.children.each do |d|
        if d.is_a? Directory
            dirs += get_dirs_recursively(d)
        end
    end

    return dirs
end

used_space = root.size
reclaim_target = DESIRED_SPACE - (TOTAL_SPACE - used_space)
dirs = get_dirs_recursively(root)

dir_to_delete = dirs.sort_by { |d| d.size }.find { |d| d.size >= reclaim_target }

unless dir_to_delete.nil?
    puts dir_to_delete.size
end