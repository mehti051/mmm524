 -- This plugin will allow the admin to blacklist users who will be unable to
 -- use the bot. This plugin should be at the top of your plugin list in config.

if not database.blacklist then
	database.blacklist = {}
end

local triggers = {
	''
}

 local action = function(msg)

	if database.blacklist[msg.from.id_str] then
		return -- End if the sender is blacklisted.
	end

	if not string.match(msg.text_lower, '^/blacklist') then
		return true
	end

	if msg.from.id ~= config.admin then
		return -- End if the user isn't admin.
	end

	local input = msg.text:input()
	if not input then
		if msg.reply_to_message then
			input = tostring(msg.reply_to_message.from.id)
		else
			sendReply(msg, 'You must use this command via reply or by specifying a user\'s ID.')
			return
		end
	end

	if database.blacklist[input] then
		database.blacklist[input] = nil
		sendReply(msg, input .. ' has been removed from the blacklist.')
	else
		database.blacklist[input] = true
		sendReply(msg, input .. ' has been added to the blacklist.')
	end

 end

 return {
	action = action,
	triggers = triggers
}
