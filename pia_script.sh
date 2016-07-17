#!/bin/sh

if [ "$1" = "start" ]; then
	shift
	ip rule add from $4/32 table 100
	ip route replace default dev $1 table 100

	{% if accumulator|default %}
		# START included code
		{% for block in accumulator['on_up']|default %}
			{{ block }}
		{% endfor %}
		# END included code
	{% endif %}
elif [ "$1" = "stop" ]; then
	shift
	ip rule delete from $4/32 2> /dev/null
	ip route flush table 100

	{% if accumulator|default %}
		# START included code
		{% for block in accumulator['on_down']|default %}
			{{ block }}
		{% endfor %}
		# END included code
	{% endif %}
fi
