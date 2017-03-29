/// this mixin provides mouse hover events handling
Object {
	property bool value;			///< is 'true' if item if hovered, 'false' otherwise
	property bool enabled: true;	///< enable/disable mixin
	property string cursor;			///< mouse cursor

	///@private
	constructor: {
		this.element = this.parent.element;
		this.parent.style('cursor', this.cursor)
		this._bindHover(this.enabled)
		this._bindActiveHover(this.activeHoverEnabled)
	}

	///@private
	onCursorChanged: {
		this.parent.style('cursor', value)
	}

	///@private
	function _bindHover(value) {
		if (value && !this._hmHoverBinder) {
			this._hmHoverBinder = new _globals.core.EventBinder(this.parent.element)
			this._hmHoverBinder.on('mouseenter', function() { this.value = true }.bind(this))
			this._hmHoverBinder.on('mouseleave', function() { this.value = false }.bind(this))
		}
		if (this._hmHoverBinder)
			this._hmHoverBinder.enable(value)
	}

	///@private
	onEnabledChanged: { this._bindHover(value) }
}
