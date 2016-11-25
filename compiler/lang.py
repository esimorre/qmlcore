import re

def value_is_trivial(value):
	if value is None or not isinstance(value, str):
		return False
	if value[0] == '(' and value[-1] == ')':
		value = value[1:-1]
	if value == 'true' or value == 'false':
		return True
	try:
		float(value)
		return True
	except:
		pass
	if value[0] == '"' and value[-1] == '"':
		if value.count('"') == value.count('\\"') + 2:
			return True
	#print "?trivial", value
	return False

class DocumentationString(object):
	def __init__(self, text):
		self.text = text

class Entity(object):
	def __init__(self):
		self.doc = None

class Component(Entity):
	def __init__(self, name, children):
		super(Component, self).__init__()
		self.name = name
		self.children = children

class Property(Entity):
	def __init__(self, type, name, value = None):
		super(Property, self).__init__()
		self.type = type
		self.name = name
		self.value = value

	def is_trivial(self):
		return value_is_trivial(self.value)

class AliasProperty(Entity):
	def __init__(self, name, target):
		super(AliasProperty, self).__init__()
		self.name = name
		self.target = target

class EnumProperty(Entity):
	def __init__(self, name, values, default):
		super(EnumProperty, self).__init__()
		self.name = name
		self.values = values
		self.default = default

class Constructor(Entity):
	def __init__(self, args, code):
		super(Constructor, self).__init__()
		if len(args) != 0:
			raise Exception("no arguments for constructor allowed")
		self.code = code

class Method(Entity):
	def __init__(self, name, args, code, event):
		super(Method, self).__init__()
		self.name = name
		self.args = args
		self.code = code
		self.event = event

class IdAssignment(Entity):
	def __init__(self, name):
		super(IdAssignment, self).__init__()
		self.name = name

class Assignment(Entity):
	re_name = re.compile('<property-name>')

	def __init__(self, target, value):
		super(Assignment, self).__init__()
		self.target = target

		def replace_name(m):
			dot = target.rfind('.')
			name = target.substr(dot + 1) if dot >= 0 else target
			return name

		self.value = Assignment.re_name.sub(replace_name, value) if isinstance(value, str) else value

	def is_trivial(self):
		return value_is_trivial(self.value)

class AssignmentScope(Entity):
	def __init__(self, target, values):
		super(AssignmentScope, self).__init__()
		self.target = target
		self.values = values

class Behavior(Entity):
	def __init__(self, target, animation):
		super(Behavior, self).__init__()
		self.target = target
		self.animation = animation

class Signal(Entity):
	def __init__(self, name):
		super(Signal, self).__init__()
		self.name = name

class ListElement(Entity):
	def __init__(self, data):
		super(ListElement, self).__init__()
		self.data = data
