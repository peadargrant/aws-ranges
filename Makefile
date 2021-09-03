default: requested_ranges.txt

.SECONDARY:

ip-ranges.json:
	curl -o $@ "https://ip-ranges.amazonaws.com/ip-ranges.json"

requested_ranges.txt: ip-ranges.json
	./aws_ip_ranges.pl $< > $@


