-- Lua tutorial
-- When you put "--" before some text, that text becomes a comment
-- Comments are not counted as code
variable = "value"
-- Variables can be declared like above
-- They can also be numbers
variable = 42
variable = 3.14159265
-- Or boolean
-- Boolean means true or false
trump_sucks = true
-- Local variables are declared by putting "local" before declaration
local foo = "yuck"
-- When a variable is local, it can only be accessed in the current block of code
-- Example:
TrumpIsFat = true
if TrumpIsFat then
	local Trump = "Bad choice for president"
end
print( Trump )
-- The above code would give an error because all local variables get forgotten once their current block of code ends
-- A block of code is code that has a defined start and end point
-- Examples:
if true then
	-- Code in this block
end

while true do
	-- Code in this block
end
-- You mayhave noticed the use of the word "if"
-- This means that you test if something is true
-- If the criteria is met, code is run
if Player:IsDead() then
	Player:Respawn()
end

if Player:Touching( "health_pack" ) then
	if Player:Health() == 100 then return end
	Player:SetHealth( 100 )
end
-- Whenever you do "return end" inside a block of code, it stops the block of code
if true then
	if true then
		return end
		print( "This WILL NOT be printed because the block of code is over already" )
	end
	print( "This WILL be printed because it is outside the block of code" )
end
