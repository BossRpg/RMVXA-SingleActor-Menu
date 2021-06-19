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
    draw_actor_face(actor, rect.x + 1, rect.y + 1, enabled)
    draw_actor_simple_status(actor, rect.x + 108, rect.y + line_height / 2)
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
    @viewport.rect.width = Graphics.width
    @viewport.rect.height = Graphics.height
    window.hide.deactivate
    activate_item_window
  end
end
