
async function loadGDScript(filePath, elementId) {
    try {
        const response = await fetch(filePath);
        if (!response.ok) throw new Error(`Failed to load GDScript file: ${filePath}`);
        
        const scriptContent = await response.text();
        const codeElement = document.getElementById(elementId);

        codeElement.textContent = scriptContent;
        Prism.highlightElement(codeElement);

        // if (window.Prism && Prism.languages.python) {
        //     Prism.languages.gdscript = Prism.languages.python;
        //     Prism.highlightElement(codeElement);
        // } else {
        //     console.warn("Prism or Prism Python component is missing from the page.");
        // }

    } catch (error) {
        console.error(error);
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = '# Error loading script';
        
        if (window.Prism) Prism.highlightElement(errorElement);
    }
}



function patchPrismGDScript() {
    if (!window.Prism) {
        console.error("Prism.js must be loaded before patching GDScript.");
        return;
    }

    // Define the patch rules for GDScript 2.0 (Godot 4+)
    Prism.languages.gdscript = {
        'comment': /#.*/,
        
        // Matches Godot 4 annotations: @export, @onready, @rpc, etc.
        'annotation': {
            pattern: /@\w+/,
            alias: 'important'
        },
        
        // Single, double, and triple-quoted multiline strings
        'string': {
            pattern: /(?:r|b)?(?:"{3}[\s\S]*?"{3}|'{3}[\s\S]*?'{3}|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')/i,
            greedy: true
        },
        
        // Extends and class definitions
        'class-name': {
            pattern: /(\b(?:extends|class)\s+)\w+(?:\.\w+)*/,
            lookbehind: true
        },
        
        // Complete keyword list updated for Godot 4
        'keyword': /\b(?:as|assert|await|breakpoint|class|class_name|const|enum|enum_name|export|extends|for|func|if|else|elif|in|is|master|onready|pass|preload|puppet|remote|remotesync|return|self|signal|static|super|tool|var|void|while|yield)\b/,
        
        'boolean': /\b(?:true|false)\b/,
        'null': /\bnull\b/,
        
        // Core built-in functions
        'builtin': /\b(?:abs|acos|asin|atan|atan2|bytes2var|ceil|char|clamp|convert|cos|cosh|db2linear|decimals|dectime|deg2rad|dict2inst|ease|empty|export|exp|floor|fmod|fposmod|funcref|hash|inst2dict|instance_from_id|is_inf|is_nan|len|linear2db|load|log|max|min|move_toward|nearest_po2|parse_json|pow|print|print_stack|printerr|printraw|prints|printt|rand_range|rand_seed|randf|randi|randomize|range|rad2deg|round|seed|sign|sin|sinh|sqrt|stepify|str|str2var|tan|tanh|to_json|type_exists|typeof|validate_json|var2bytes|var2str|weakref|wrapf|wrapi)\b/,
        
        // Engine Data and Object Classes
        'class-type': {
            pattern: /\b(?:Array|Dictionary|Vector2|Vector2i|Vector3|Vector3i|Vector4|Vector4i|Color|Rect2|Rect2i|Transform2D|Transform3D|Plane|Quaternion|Basis|AABB|Projection|RID|Callable|Signal|NodePath|Object|String|StringName|Node|Node2D|CanvasItem|Control|Spacer|Window|Engine)\b/,
            alias: 'class-name'
        },
        
        'function': /\b[a-z_]\w*(?=\s*\()/i,
        'number': /\b(?:0x[a-fA-F0-9]+|\d+(?:\.\d+)?(?:e[+-]?\d+)?)\b/i,
        'operator': /->|[-+*/%&|^!=<>]=?|~|\b(?:and|or|not)\b/,
        'punctuation': /[{}[\],.;:]/
    };

    // Alias 'gd' shorthand class (so <code class="language-gd"> also works)
    Prism.languages.gd = Prism.languages.gdscript;
}