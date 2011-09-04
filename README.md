#How it works

The format for converting xml to json is as follows.  
A tag is split into three things :

- a name referencing its tag name
- its attributes
- its children.

Text children are put into there own node for easy selection.

As such, the format looks similar to: (Note: <> specify values that are arbitrary)

	{
		"name":"<tagname>",
		"attributes":{
			"<attr1>":"<val1>",
			"<attr2>":"<val2>",
			...
		},
		"children":[{
			"name":"<tagname>",
			"attributes":{
				"<attr1>":"<val1>"
				...
		},{
			"text": "<textstring>"
		},{
			"name":"<tagname>",
			"attributes":{
				"<attr1>":"<val1>"
				...
		}]
	}