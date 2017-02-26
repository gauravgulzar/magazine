# a = 2d array
# x,y = x and y coordinates respectively
# c = required color
def fill(a,x,y,c)
	return nil unless a.is_a?(Array) && a[0].is_a?(Array)
	q = Queue.new
	q << [x,y]
	rows = a.length
	cols = a[0].length
	d = {} # a hash to mark visited cells
	t = a[x][y] # t is the target color which we need to chane
	while !q.empty?
		p = q.pop
		a[p[0]][p[1]] = c
		d[p] = true

		# adjacent cells in upper row
		q << [p[0]-1, p[1]-1] if p[0]-1 >= 0 && p[1]-1 >= 0 && d[[p[0]-1,p[1]-1]] != true && a[p[0]-1][p[1]-1] == t
		q << [p[0]-1, p[1]] if p[0]-1 >= 0 && d[ [p[0]-1,p[1]] ] != true && a[p[0]-1][p[1]] == t
		q << [p[0]-1, p[1]+1] if p[0]-1 >= 0 && p[1]+1 < cols && d[ [p[0]-1,p[1]+1] ] != true && a[p[0]-1][p[1]+1] == t

		# adjacent cells in lower row
		q << [p[0]+1, p[1]+1] if p[0]+1 < rows && p[1]+1 < cols && d[[p[0]+1,p[1]+1]] != true && a[p[0]+1][p[1]+1] == t
		q << [p[0]+1, p[1]] if p[0]+1 < rows && d[ [p[0]+1,p[1]] ] != true && a[p[0]+1][p[1]] == t
		q << [p[0]+1, p[1]+1] if p[0]+1 < rows && p[1]+1 < cols && d[ [p[0]+1,p[1]+1] ] != true && a[p[0]+1][p[1]+1] == t

		# left cell
		q << [p[0], p[1]-1] if p[1]-1 >= 0 && d[[p[0],p[1]-1]] != true && a[p[0]][p[1]-1] == t

		# right cell
		q << [p[0], p[1]+1] if p[1]+1 < cols && d[[p[0],p[1]+1]] != true && a[p[0]][p[1]+1] == t

	end
	a
end
