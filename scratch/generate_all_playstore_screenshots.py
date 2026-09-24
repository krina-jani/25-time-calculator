import os
from PIL import Image, ImageDraw, ImageFont

root_dir = r"c:\krina\time-calculator"
artifact_dir = r"C:\Users\Admin\.gemini\antigravity-ide\brain\d88f475c-288c-408b-bdaf-aafbdf219062"
assets_dir = os.path.join(root_dir, "playstore_assets")

os.makedirs(assets_dir, exist_ok=True)
os.makedirs(artifact_dir, exist_ok=True)

base_logo_path = os.path.join(root_dir, "assets", "icons", "app_logo.png")
logo_img = Image.open(base_logo_path).convert("RGBA")

def save_image(img, filename):
    p_root = os.path.join(root_dir, filename)
    p_assets = os.path.join(assets_dir, filename)
    p_art = os.path.join(artifact_dir, filename)
    img.save(p_root, "PNG")
    img.save(p_assets, "PNG")
    img.save(p_art, "PNG")
    print(f"Saved {filename}: {img.size}")

# -------------------------------------------------------------
# 1. APP ICON (512x512)
# -------------------------------------------------------------
icon_512 = Image.new("RGBA", (512, 512), (255, 255, 255, 0))
bg_icon = Image.new("RGBA", (512, 512), (30, 58, 138, 255)) # Deep blue #1E3A8A
mask_icon = Image.new("L", (512, 512), 0)
ImageDraw.Draw(mask_icon).rounded_rectangle([0, 0, 512, 512], radius=110, fill=255)
icon_512.paste(bg_icon, (0, 0), mask_icon)

logo_360 = logo_img.resize((360, 360), Image.Resampling.LANCZOS)
icon_512.paste(logo_360, (76, 76), logo_360)
save_image(icon_512, "app_icon_512x512.png")

# -------------------------------------------------------------
# 2. FEATURE GRAPHIC (1024x500)
# -------------------------------------------------------------
feat_w, feat_h = 1024, 500
feature_img = Image.new("RGBA", (feat_w, feat_h), (255, 255, 255, 255))
bg_draw = ImageDraw.Draw(feature_img)
for y in range(feat_h):
    r = int(30 + (37 - 30) * y / feat_h)
    g = int(58 + (99 - 58) * y / feat_h)
    b = int(138 + (235 - 138) * y / feat_h)
    bg_draw.line([(0, y), (feat_w, y)], fill=(r, g, b, 255))

bg_draw.ellipse([700, -100, 1150, 350], fill=(255, 255, 255, 20))
bg_draw.ellipse([-100, 200, 350, 650], fill=(255, 255, 255, 15))

feat_logo = logo_img.resize((180, 180), Image.Resampling.LANCZOS)
feature_img.paste(feat_logo, (80, 160), feat_logo)

try:
    font_title = ImageFont.truetype("arial.ttf", 52)
    font_sub = ImageFont.truetype("arial.ttf", 26)
    font_badge = ImageFont.truetype("arialbd.ttf", 22)
except:
    font_title = font_sub = font_badge = ImageFont.load_default()

t_draw = ImageDraw.Draw(feature_img)
t_draw.text((290, 170), "Time Calculator", fill=(255, 255, 255, 255), font=font_title)
t_draw.text((290, 240), "Add & Subtract Days, Hours, Minutes, Seconds", fill=(226, 232, 240, 255), font=font_sub)

badge_bg = Image.new("RGBA", (450, 48), (255, 255, 255, 30))
badge_mask = Image.new("L", (450, 48), 0)
ImageDraw.Draw(badge_mask).rounded_rectangle([0, 0, 450, 48], radius=24, fill=255)
feature_img.paste(badge_bg, (290, 290), badge_mask)

b_draw = ImageDraw.Draw(feature_img)
b_draw.text((310, 302), "Fast • Offline • Precise • No Ads", fill=(255, 255, 255, 255), font=font_badge)

save_image(feature_img, "feature_graphic_1024x500.png")

# Helper for drawing UI components dynamically onto any Canvas
def render_calculator_ui(canvas, sw, sh, header_title, val1, val2, result_vals, result_summary, is_sub=False):
    d = ImageDraw.Draw(canvas)
    
    # Scale factors based on width
    sf = sw / 1080.0
    
    try:
        f_status = ImageFont.truetype("arialbd.ttf", int(32 * sf))
        f_appbar = ImageFont.truetype("arialbd.ttf", int(44 * sf))
        f_card_t = ImageFont.truetype("arialbd.ttf", int(48 * sf))
        f_card_desc = ImageFont.truetype("arial.ttf", int(32 * sf))
        f_label = ImageFont.truetype("arialbd.ttf", int(36 * sf))
        f_val = ImageFont.truetype("arialbd.ttf", int(42 * sf))
        f_btn = ImageFont.truetype("arialbd.ttf", int(38 * sf))
    except:
        f_status = f_appbar = f_card_t = f_card_desc = f_label = f_val = f_btn = ImageFont.load_default()

    # Top Status Bar
    d.rectangle([0, 0, sw, int(90 * sf)], fill=(255, 255, 255, 255))
    d.text((int(60 * sf), int(24 * sf)), "9:41", fill=(15, 23, 42, 255), font=f_status)
    
    # App Bar
    d.rectangle([0, int(90 * sf), sw, int(220 * sf)], fill=(255, 255, 255, 255))
    app_logo_s = logo_img.resize((int(70 * sf), int(70 * sf)), Image.Resampling.LANCZOS)
    canvas.paste(app_logo_s, (int(50 * sf), int(120 * sf)), app_logo_s)
    d.text((int(140 * sf), int(130 * sf)), "Time Calculator", fill=(15, 23, 42, 255), font=f_appbar)
    
    # Info icon
    d.ellipse([int(960 * sf), int(130 * sf), int(1020 * sf), int(190 * sf)], outline=(37, 99, 235, 255), width=int(4 * sf))
    d.text((int(982 * sf), int(140 * sf)), "i", fill=(37, 99, 235, 255), font=f_status)

    # Top Banner Card
    d.rounded_rectangle([int(40 * sf), int(260 * sf), int(1040 * sf), int(520 * sf)], radius=int(24 * sf), fill=(30, 58, 138, 255))
    d.text((int(80 * sf), int(290 * sf)), header_title, fill=(255, 255, 255, 255), font=f_card_t)
    d.text((int(80 * sf), int(360 * sf)), "Calculate total duration by adding or subtracting\ntwo time sets (Days, Hours, Minutes, Seconds).", fill=(226, 232, 240, 255), font=f_card_desc)

    # Main Container Box
    d.rounded_rectangle([int(40 * sf), int(560 * sf), int(1040 * sf), int(2150 * sf)], radius=int(24 * sf), fill=(235, 236, 239, 255), outline=(203, 213, 225, 255), width=int(3 * sf))
    
    # Column Headers
    cols = ["Day", "Hour", "Minute", "Second"]
    for i, col in enumerate(cols):
        cx = int((70 + i * 240) * sf)
        d.text((cx + int(50 * sf), int(600 * sf)), col, fill=(15, 23, 42, 255), font=f_label)

    # Row 1 Inputs
    for i, v in enumerate(val1):
        x = int((70 + i * 240) * sf)
        d.rounded_rectangle([x, int(670 * sf), x + int(200 * sf), int(780 * sf)], radius=int(12 * sf), fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=int(3 * sf))
        d.text((x + int(70 * sf), int(700 * sf)), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Radio options
    d.rounded_rectangle([int(320 * sf), int(830 * sf), int(760 * sf), int(930 * sf)], radius=int(50 * sf), fill=(255, 255, 255, 255), outline=(203, 213, 225, 255), width=int(3 * sf))
    # Add option
    d.ellipse([int(350 * sf), int(855 * sf), int(400 * sf), int(905 * sf)], outline=(37, 99, 235, 255) if not is_sub else (100, 100, 100, 255), width=int(4 * sf))
    if not is_sub:
        d.ellipse([int(365 * sf), int(870 * sf), int(385 * sf), int(890 * sf)], fill=(37, 99, 235, 255))
    d.text((int(415 * sf), int(855 * sf)), "Add+", fill=(30, 58, 138, 255) if not is_sub else (71, 85, 105, 255), font=f_label)

    # Subtract option
    d.ellipse([int(560 * sf), int(855 * sf), int(610 * sf), int(905 * sf)], outline=(37, 99, 235, 255) if is_sub else (100, 100, 100, 255), width=int(4 * sf))
    if is_sub:
        d.ellipse([int(575 * sf), int(870 * sf), int(595 * sf), int(890 * sf)], fill=(37, 99, 235, 255))
    d.text((int(625 * sf), int(855 * sf)), "Subtract–", fill=(30, 58, 138, 255) if is_sub else (71, 85, 105, 255), font=f_label)

    # Row 2 Inputs
    for i, v in enumerate(val2):
        x = int((70 + i * 240) * sf)
        d.rounded_rectangle([x, int(980 * sf), x + int(200 * sf), int(1090 * sf)], radius=int(12 * sf), fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=int(3 * sf))
        d.text((x + int(70 * sf), int(1010 * sf)), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Equals Circle
    d.ellipse([int(490 * sf), int(1130 * sf), int(590 * sf), int(1230 * sf)], fill=(30, 41, 59, 255))
    d.text((int(520 * sf), int(1145 * sf)), "=", fill=(255, 255, 255, 255), font=f_appbar)

    # Row 3 Result Fields
    for i, v in enumerate(result_vals):
        x = int((70 + i * 240) * sf)
        d.rounded_rectangle([x, int(1270 * sf), x + int(200 * sf), int(1380 * sf)], radius=int(12 * sf), fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=int(3 * sf))
        d.text((x + int(60 * sf), int(1300 * sf)), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Result Summary Banner
    d.rounded_rectangle([int(80 * sf), int(1430 * sf), int(1000 * sf), int(1570 * sf)], radius=int(20 * sf), fill=(240, 253, 244, 255), outline=(134, 239, 172, 255), width=int(3 * sf))
    d.text((int(120 * sf), int(1475 * sf)), result_summary, fill=(21, 128, 61, 255), font=f_label)

    # Buttons
    d.rounded_rectangle([int(180 * sf), int(1650 * sf), int(580 * sf), int(1780 * sf)], radius=int(20 * sf), fill=(75, 123, 31, 255))
    d.text((int(270 * sf), int(1690 * sf)), "Calculate ▶", fill=(255, 255, 255, 255), font=f_btn)

    d.rounded_rectangle([int(620 * sf), int(1650 * sf), int(900 * sf), int(1780 * sf)], radius=int(20 * sf), fill=(138, 138, 138, 255))
    d.text((int(710 * sf), int(1690 * sf)), "Clear", fill=(255, 255, 255, 255), font=f_btn)

    d.text((int(340 * sf), int(2050 * sf)), "Emperor Smart Solutions", fill=(148, 163, 184, 255), font=f_card_desc)

def render_about_ui(canvas, sw, sh):
    d = ImageDraw.Draw(canvas)
    sf = sw / 1080.0
    
    try:
        f_appbar = ImageFont.truetype("arialbd.ttf", int(44 * sf))
        f_sec = ImageFont.truetype("arialbd.ttf", int(36 * sf))
        f_item = ImageFont.truetype("arialbd.ttf", int(40 * sf))
        f_sub = ImageFont.truetype("arial.ttf", int(32 * sf))
    except:
        f_appbar = f_sec = f_item = f_sub = ImageFont.load_default()

    d.rectangle([0, int(90 * sf), sw, int(220 * sf)], fill=(255, 255, 255, 255))
    d.text((int(80 * sf), int(130 * sf)), "About", fill=(30, 41, 59, 255), font=f_appbar)

    d.text((int(60 * sf), int(260 * sf)), "LEGAL & GOVERNANCE", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([int(40 * sf), int(310 * sf), int(1040 * sf), int(510 * sf)], radius=int(24 * sf), fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=int(3 * sf))
    d.text((int(100 * sf), int(360 * sf)), "Privacy Policy", fill=(15, 23, 42, 255), font=f_item)
    d.text((int(100 * sf), int(420 * sf)), "Read full data safety practices & privacy policy", fill=(100, 116, 139, 255), font=f_sub)

    d.text((int(60 * sf), int(560 * sf)), "CONNECT WITH US", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([int(40 * sf), int(610 * sf), int(1040 * sf), int(1130 * sf)], radius=int(24 * sf), fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=int(3 * sf))
    
    items = [
        ("Instagram", "Follow Emperor Smart Solutions"),
        ("LinkedIn", "Follow Emperor Smart Solutions"),
        ("Contact Us", "+91 63543 51080")
    ]
    for i, (t, s) in enumerate(items):
        y = int((650 + i * 160) * sf)
        d.text((int(100 * sf), y), t, fill=(15, 23, 42, 255), font=f_item)
        d.text((int(100 * sf), y + int(55 * sf)), s, fill=(100, 116, 139, 255), font=f_sub)

    d.text((int(60 * sf), int(1180 * sf)), "DEVELOPER", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([int(40 * sf), int(1230 * sf), int(1040 * sf), int(1550 * sf)], radius=int(24 * sf), fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=int(3 * sf))
    d.text((int(100 * sf), int(1280 * sf)), "Emperor Smart Solutions", fill=(15, 23, 42, 255), font=f_item)
    d.text((int(100 * sf), int(1350 * sf)), "Emperor Smart Solutions develops software, mobile\napplications, digital products, and utility applications.", fill=(100, 116, 139, 255), font=f_sub)

    d.text((int(380 * sf), int(1750 * sf)), "Time Calculator v1.0.0", fill=(148, 163, 184, 255), font=f_sub)


# -------------------------------------------------------------
# 3. PHONE SCREENSHOTS (1080x2400)
# -------------------------------------------------------------
p1 = Image.new("RGBA", (1080, 2400), (241, 245, 249, 255))
render_calculator_ui(p1, 1080, 2400, "Time Addition", [2, 14, 45, 30], [1, 12, 20, 45], [4, 3, 6, 15], "Result: 4 Days, 3 Hours, 6 Mins, 15 Secs", is_sub=False)
save_image(p1, "phone_screenshot_1.png")

p2 = Image.new("RGBA", (1080, 2400), (241, 245, 249, 255))
render_calculator_ui(p2, 1080, 2400, "Time Subtraction", [5, 10, 0, 0], [2, 15, 30, 0], [2, 18, 30, 0], "Result: 2 Days, 18 Hours, 30 Mins, 0 Secs", is_sub=True)
save_image(p2, "phone_screenshot_2.png")

p3 = Image.new("RGBA", (1080, 2400), (241, 245, 249, 255))
render_calculator_ui(p3, 1080, 2400, "Quick Time Add & Clear", [0, 8, 15, 0], [0, 4, 45, 0], [0, 13, 0, 0], "Result: 0 Days, 13 Hours, 0 Mins, 0 Secs", is_sub=False)
save_image(p3, "phone_screenshot_3.png")

p4 = Image.new("RGBA", (1080, 2400), (244, 246, 249, 255))
render_about_ui(p4, 1080, 2400)
save_image(p4, "phone_screenshot_4.png")

# -------------------------------------------------------------
# 4. 7-INCH TABLET SCREENSHOTS (1200x1920)
# -------------------------------------------------------------
t7_1 = Image.new("RGBA", (1200, 1920), (241, 245, 249, 255))
render_calculator_ui(t7_1, 1200, 1920, "Time Addition (Tablet)", [2, 14, 45, 30], [1, 12, 20, 45], [4, 3, 6, 15], "Result: 4 Days, 3 Hours, 6 Mins, 15 Secs", is_sub=False)
save_image(t7_1, "tablet_7inch_screenshot_1.png")

t7_2 = Image.new("RGBA", (1200, 1920), (241, 245, 249, 255))
render_calculator_ui(t7_2, 1200, 1920, "Time Subtraction (Tablet)", [5, 10, 0, 0], [2, 15, 30, 0], [2, 18, 30, 0], "Result: 2 Days, 18 Hours, 30 Mins, 0 Secs", is_sub=True)
save_image(t7_2, "tablet_7inch_screenshot_2.png")

t7_3 = Image.new("RGBA", (1200, 1920), (244, 246, 249, 255))
render_about_ui(t7_3, 1200, 1920)
save_image(t7_3, "tablet_7inch_screenshot_3.png")

# -------------------------------------------------------------
# 5. 10-INCH TABLET SCREENSHOTS (1600x2560)
# -------------------------------------------------------------
t10_1 = Image.new("RGBA", (1600, 2560), (241, 245, 249, 255))
render_calculator_ui(t10_1, 1600, 2560, "Time Addition (10\" Tablet)", [2, 14, 45, 30], [1, 12, 20, 45], [4, 3, 6, 15], "Result: 4 Days, 3 Hours, 6 Mins, 15 Secs", is_sub=False)
save_image(t10_1, "tablet_10inch_screenshot_1.png")

t10_2 = Image.new("RGBA", (1600, 2560), (241, 245, 249, 255))
render_calculator_ui(t10_2, 1600, 2560, "Time Subtraction (10\" Tablet)", [5, 10, 0, 0], [2, 15, 30, 0], [2, 18, 30, 0], "Result: 2 Days, 18 Hours, 30 Mins, 0 Secs", is_sub=True)
save_image(t10_2, "tablet_10inch_screenshot_2.png")

t10_3 = Image.new("RGBA", (1600, 2560), (244, 246, 249, 255))
render_about_ui(t10_3, 1600, 2560)
save_image(t10_3, "tablet_10inch_screenshot_3.png")

# -------------------------------------------------------------
# 6. DESKTOP / CHROMEBOOK LANDSCAPE (1920x1080)
# -------------------------------------------------------------
def render_desktop_ui(sw, sh, title, val1, val2, res_vals, res_summary, is_sub=False):
    scr = Image.new("RGBA", (sw, sh), (241, 245, 249, 255))
    d = ImageDraw.Draw(scr)
    try:
        f_title = ImageFont.truetype("arialbd.ttf", 36)
        f_sub = ImageFont.truetype("arial.ttf", 24)
        f_label = ImageFont.truetype("arialbd.ttf", 26)
        f_val = ImageFont.truetype("arialbd.ttf", 30)
    except:
        f_title = f_sub = f_label = f_val = ImageFont.load_default()

    # Desktop App Bar Header
    d.rectangle([0, 0, sw, 80], fill=(255, 255, 255, 255))
    desktop_logo = logo_img.resize((50, 50), Image.Resampling.LANCZOS)
    scr.paste(desktop_logo, (40, 15), desktop_logo)
    d.text((110, 22), "Time Calculator", fill=(15, 23, 42, 255), font=f_title)

    # Left Panel: Info Card
    d.rounded_rectangle([40, 120, 600, 1000], radius=16, fill=(30, 58, 138, 255))
    d.text((70, 160), title, fill=(255, 255, 255, 255), font=f_title)
    d.text((70, 230), "Calculate total duration by adding or\nsubtracting two time sets in Days, Hours,\nMinutes, and Seconds.", fill=(226, 232, 240, 255), font=f_sub)
    d.text((70, 400), "• Full Precision Offline Engine\n• Zero Permissions Required\n• Fast & Easy Interface", fill=(226, 232, 240, 255), font=f_sub)

    # Right Panel: Main Calculator UI Card
    d.rounded_rectangle([640, 120, 1880, 1000], radius=16, fill=(235, 236, 239, 255), outline=(203, 213, 225, 255), width=2)

    cols = ["Day", "Hour", "Minute", "Second"]
    for i, col in enumerate(cols):
        cx = 680 + i * 290
        d.text((cx + 80, 160), col, fill=(15, 23, 42, 255), font=f_label)

    # Inputs Row 1
    for i, v in enumerate(val1):
        x = 680 + i * 290
        d.rounded_rectangle([x, 210, x + 250, 300], radius=8, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=2)
        d.text((x + 105, 235), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Selector
    d.rounded_rectangle([1080, 330, 1440, 400], radius=35, fill=(255, 255, 255, 255), outline=(203, 213, 225, 255), width=2)
    d.text((1120, 350), "Add+" if not is_sub else "Subtract–", fill=(30, 58, 138, 255), font=f_label)

    # Inputs Row 2
    for i, v in enumerate(val2):
        x = 680 + i * 290
        d.rounded_rectangle([x, 430, x + 250, 520], radius=8, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=2)
        d.text((x + 105, 455), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Equals & Result Row
    d.ellipse([1230, 540, 1290, 600], fill=(30, 41, 59, 255))
    d.text((1250, 550), "=", fill=(255, 255, 255, 255), font=f_title)

    for i, v in enumerate(res_vals):
        x = 680 + i * 290
        d.rounded_rectangle([x, 620, x + 250, 710], radius=8, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=2)
        d.text((x + 95, 645), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Summary Alert Banner
    d.rounded_rectangle([680, 750, 1840, 840], radius=12, fill=(240, 253, 244, 255), outline=(134, 239, 172, 255), width=2)
    d.text((720, 775), res_summary, fill=(21, 128, 61, 255), font=f_label)

    # Buttons
    d.rounded_rectangle([1020, 870, 1280, 950], radius=12, fill=(75, 123, 31, 255))
    d.text((1070, 892), "Calculate ▶", fill=(255, 255, 255, 255), font=f_label)

    d.rounded_rectangle([1320, 870, 1500, 950], radius=12, fill=(138, 138, 138, 255))
    d.text((1380, 892), "Clear", fill=(255, 255, 255, 255), font=f_label)

    return scr

desk1 = render_desktop_ui(1920, 1080, "Desktop Time Addition", [2, 14, 45, 30], [1, 12, 20, 45], [4, 3, 6, 15], "Result: 4 Days, 3 Hours, 6 Mins, 15 Secs", is_sub=False)
save_image(desk1, "desktop_screenshot_1.png")

desk2 = render_desktop_ui(1920, 1080, "Desktop Time Subtraction", [5, 10, 0, 0], [2, 15, 30, 0], [2, 18, 30, 0], "Result: 2 Days, 18 Hours, 30 Mins, 0 Secs", is_sub=True)
save_image(desk2, "desktop_screenshot_2.png")

print("\n🎉 ALL Play Store Screenshot image sets generated in root folder!")
