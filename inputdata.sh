input_data() {
	echo -e ',
            {
               "version":"'$VERSION'",
               "date":"",
               "additional":"",
               "type":"'$TYPE'",
               "faketad":"",
               "system":"3DS"
            }' >> newdir.json
}

input_data_start() {
	echo -e '
      "slug":"'$NAME'",
      "title":"'$NAME'",
      "title_short":"",
      "desc":"Todo",
      "category":"SDK",
      "category_broad":"SDK",
      "target":"CARD",
      "banner":"Test Program",
      "banner_1":"Nintendo",
      "icon_alt":"",
      "published":"true",
      "undumped":"",
      "danger":"",
      "credit":[],
      "origin":"- NDP",
      "source":"",
      "versions":[' >> newdir.json
}

input_data_end() {
	echo -e '
         ]
      },' >> newdir.json
}

write_html() {
	echo '---
layout: devinfo
app: '$NAME'
preview: /preview.png
---' #> /home/rvtr/Desktop/rmc_website_3ds/3dsdev/"$NAME".html

}

write_folder() {
	mkdir /home/rvtr/Desktop/rmc_website_3ds/3ds-photos/"$NAME"/
}

rm -rf newdir.json

for dd in ./*; do
	NAME=$(basename $dd)

	input_data_start
	ls $dd
	for f in "${dd}"/*; do

		ff=$(echo "$f") # | sed 's/_/\./g' | sed 's/-/_/g')

    	VERSION=$(echo $ff | sed "s/$NAME//" | sed 's/.*_//' | sed 's/....$//')
    	TYPE=$(echo $ff | sed 's/.*\.//')

		input_data "$ff"
	done
	input_data_end
	write_html
	write_folder
done
