"""
SimpleBot
"""
import hlt
from collections import OrderedDict
import logging

game = hlt.Game("SimpleBot")

logging.getLogger().setLevel(logging.INFO)
logging.info("SimpleBot Starting!")

while True:

    game_map = game.update_map()
    command_queue = []

    for ship in game_map.get_me().all_ships():

        move_made = False

        # If the ship is docked
        if ship.docking_status != ship.DockingStatus.UNDOCKED:
            continue

        nearby_entities = OrderedDict(sorted(game_map.nearby_entities_by_distance(ship).items()))

        for distance, entities in nearby_entities.items():

            if move_made:
                break

            for entity in entities:

                if move_made:
                    break

                if isinstance(entity, hlt.entity.Planet):

                    # If the planet is owned
                    if entity.is_owned()\
                            and ((entity.owner.id == game_map.my_id
                                  and len(entity.all_docked_ships()) >= min(4, entity.num_docking_spots))
                                 or entity.owner.id != game_map.my_id):
                        continue

                    if ship.can_dock(entity):
                        # We add the command by appending it to the command_queue
                        command_queue.append(ship.dock(entity))
                        move_made = True
                    else:
                        nav_command = ship.navigate(ship.closest_point_to(entity), game_map,
                                                    max_corrections=18,
                                                    angular_step=5,
                                                    speed=hlt.constants.MAX_SPEED,
                                                    ignore_ships=False)
                        if nav_command:
                            command_queue.append(nav_command)
                            move_made = True

        if move_made:
            continue

        # 2nd pass
        # Attack ships since no planets
        for distance, entities in nearby_entities.items():

            if move_made:
                break

            for entity in entities:

                if move_made:
                    break

                if isinstance(entity, hlt.entity.Ship):

                    # attack other ships
                    if entity.owner and entity.owner.id == game_map.my_id:
                        continue

                    nav_command = ship.navigate(ship.closest_point_to(entity), game_map,
                                                max_corrections=18,
                                                angular_step=5,
                                                speed=hlt.constants.MAX_SPEED,
                                                ignore_ships=False)
                    if nav_command:
                        command_queue.append(nav_command)
                        move_made = True

                elif isinstance(entity, hlt.entity.Planet):

                    # attack other planets
                    if entity.owner and entity.owner.id == game_map.my_id:
                        continue

                    nav_command = ship.navigate(ship.closest_point_to(entity), game_map,
                                                max_corrections=18,
                                                angular_step=5,
                                                speed=hlt.constants.MAX_SPEED,
                                                ignore_ships=False)
                    if nav_command:
                        command_queue.append(nav_command)
                        move_made = True

    # Send our set of commands to the Halite engine for this turn
    game.send_command_queue(command_queue)