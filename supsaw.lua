-- supSawEV_test

engine.name = 'SupSawEV'

function init()  
  local function strip_trailing_zeroes(s)
    return string.format('%.2f', s):gsub("%.?0+$", "")
  end
  
  params:add_separator('header', 'engine controls')
  

  ------------------------------
  -- voice controls
  ------------------------------
  -- amp control
  params:add_control(
    'eng_amp', -- ID
    'amp', -- display name
    controlspec.new(
      0, -- min
      2, -- max
      'lin', -- warp
      0.001, -- output quantization
      1, -- default value
      '', -- string for units
      0.005 -- adjustment quantization
    ),
    -- params UI formatter:
    function(param)
      return strip_trailing_zeroes(param:get()*100)..'%'
    end
  )  
  params:set_action('eng_amp',
    function(x)
      engine.amp(x)
      screen_dirty = true
    end
  )

  -- mix control
  params:add_control('eng_mix', 'mix', 
    controlspec.new(0,1,'lin',0.001,0.5, '', 0.005))  
  params:set_action('eng_mix',
    function(x)
      engine.mix(x)
      screen_dirty = true
    end
  )

  -- detune control
  params:add_control('eng_detune', 'detune', 
    controlspec.new(0,1,'lin',0.001,0.5, '', 0.005))  
  params:set_action('eng_detune',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )

  ------------------------------
  -- voice controls
  ------------------------------

  -- decay control
  params:add_control('eng_decay', 'decay', 
  controlspec.new(0,0.9,'lin',0.001,0.3, '', 0.005))  
  params:set_action('eng_decay',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )

  -- absorb control
  params:add_control('eng_absorb', 'absorb', 
  controlspec.new(0,1,'lin',0.001,0.1, '', 0.005))  
  params:set_action('eng_absorb',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )

  -- modulation control
  params:add_control('eng_modulation', 'modulation', 
  controlspec.new(0,1,'lin',0.001,0.01, '', 0.005))  
  params:set_action('eng_modulation',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )

  -- modRate control
  params:add_control('eng_modRate', 'modRate', 
  controlspec.new(0,1,'lin',0.001,0.05, '', 0.005))  
  params:set_action('eng_modRate',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )

  -- delay control
  params:add_control('eng_delay', 'delay', 
  controlspec.new(0,1,'lin',0.001,0.3, '', 0.005))  
  params:set_action('eng_delay',
    function(x)
      engine.detune(x)
      screen_dirty = true
    end
  )



  screen_dirty = true
  redraw_timer = metro.init(
    function() -- what to perform at every tick
      if screen_dirty == true then
        redraw()
        screen_dirty = false
      end
    end,
    1/15 -- how often (15 fps)
    -- the above will repeat forever by default
  )
  redraw_timer:start()
  
end

function redraw()
  screen.clear()
  screen.move(64,32)
  screen.level(15)
  screen.font_size(12)
  screen.text_center('SupSawEV Test')
  -- screen.text_center('amp: '..params:string('eng_amp'))
  screen.update()
end

function enc(n,d)

end

function cleanup()

end