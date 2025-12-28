from subprocess import run
import sys
import time

banner_path = sys.argv[1]


seed = str(int(time.time()))

animation=[
[
"   ᨈ ܢ      ",
"  (^˕^)ᜪ_⎠  ",
"  |ˎ     )  ",
'  ૮ᒐ ""૮ᒐᐟ  ',
],
[
"  /ᐠ_^      ",
" (^˕^ )__⎠  ",
"  |ˎ     )  ",
'  ᒐ૮ ""ᒐ૮ᐟ  ',
],
[
"  ᨈ /\\      ",
" (^˕^)___/  ",
"  |ˎ     )  ",
'  ૮ᒐ ""૮ᒐᐟ  ',
],
[
"  /ᐠ_^      ",
" (^˕^ )__/  ",
"  |ˎ     )  ",
'  ᒐ૮ ""ᒐ૮ᐟ  ',
]]

frame_w = 12
frame_h = 4

with open(banner_path, 'r', encoding="utf-8") as file:
    banner = file.read().splitlines()

banner_w = len(banner[0])
banner_h = len(banner)

width = 70
height = 11

banner_x = (width - banner_w) // 2

x = 40
y = height - frame_h
i = 0
t = 0
while True:
    if x <= -frame_w:
        x = width

    frame = animation[i % 4]

    content = [' ' * width for _ in range(height)]

    # Add the banner
    for j, line in enumerate(banner):
        content[j] = content[j][:banner_x] + line + content[j][banner_x + banner_w:]

    # Add the frame
    for j, line in enumerate(frame):
        out = content[y+j]
        if x + frame_w > width:
            out = out[:x] + line[:width - x]
        elif x < 0:
            out = line[-x:] + out[frame_w + x:]
        else:
            out = out[:x] + line + out[x + frame_w:]
        content[y+j] = out

    print("\033[H\033[?25l", end="\n")
    run([f"echo -e '{'\n'.join(content)}' | lolcrab -S {seed} -z {str(t)}"], shell=True)
    time.sleep(0.05)
    t += 1
    if t % 10 == 0:
        i += 1
        x -= 1

