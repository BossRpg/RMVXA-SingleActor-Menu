#==============================================================================
# ** Window_Base
#==============================================================================
class Window_Base < Window
  #--------------------------------------------------------------------------
  # * Draw Bar HP
  #--------------------------------------------------------------------------
  def draw_actor_hp(actor, x, y, width = 224)
    draw_gauge(x, y, width, actor.hp_rate, hp_gauge_color1, hp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::hp_a)
    draw_current_and_max_values(x, y, width, actor.hp, actor.mhp, hp_color(actor), normal_color)
  end
  #--------------------------------------------------------------------------
  # * Draw Bar MP
  #--------------------------------------------------------------------------
  def draw_actor_mp(actor, x, y, width = 224)
    draw_gauge(x, y, width, actor.mp_rate, mp_gauge_color1, mp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::mp_a)
    draw_current_and_max_values(x, y, width, actor.mp, actor.mmp,
      mp_color(actor), normal_color)
  end
end

#==============================================================================
# ** Window_MenuCommand
#==============================================================================
class Window_MenuCommand < Window_Command
  def make_command_list
    add_main_commands
  end
end

#==============================================================================
# ** Window_MenuStatus
#==============================================================================
class Window_MenuStatus < Window_Selectable
  #--------------------------------------------------------------------------
  # * Get Window Height
  #--------------------------------------------------------------------------
  def window_height
    Graphics.height - 296
  end
  #--------------------------------------------------------------------------
  # * Get Item Height
  #--------------------------------------------------------------------------
  def item_height
    (height - standard_padding * 2)
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    actor = $game_party.members[index]
    enabled = $game_party.battle_members.include?(actor)
    rect = item_rect(index)
    draw_item_background(index)
    draw_actor_simple_status(actor, rect.x, rect.y + line_height / 2)
  end
end

#==============================================================================
# ** Scene_Menu
#==============================================================================
class Scene_Menu < Scene_MenuBase
  def create_command_window
    @command_window = Window_MenuCommand.new
    @command_window.set_handler(:item,      method(:command_item))
    @command_window.set_handler(:skill,     method(:on_personal_ok))
    @command_window.set_handler(:equip,     method(:on_personal_ok))
    @command_window.set_handler(:status,    method(:on_personal_ok))
    @command_window.set_handler(:cancel,    method(:return_scene))
  end
end

#==============================================================================
# ** Scene_ItemBase
#==============================================================================
class Scene_ItemBase < Scene_MenuBase
  def show_sub_window(window)
    window.y = Graphics.height - 120
    window.width = Graphics.width
    @viewport.rect.width = Graphics.width
    @viewport.rect.height = Graphics.height - 120
    window.show.activate
  end
  def hide_sub_window(window)
    window.hide.deactivate
    activate_item_window
  end
end

#==============================================================================
# ** Scene_Item
#==============================================================================
class Scene_Item < Scene_ItemBase
  def create_item_window
    wy = @category_window.y + @category_window.height
    wh = (Graphics.height - wy) - 120
    @item_window = Window_ItemList.new(0, wy, Graphics.width, wh)
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.set_handler(:ok,     method(:on_item_ok))
    @item_window.set_handler(:cancel, method(:on_item_cancel))
    @category_window.item_window = @item_window
  end
end
