import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

out_dir = r"c:\krina\time-calculator\play_store_assets"
artifact_dir = r"C:\Users\Admin\.gemini\antigravity-ide\brain\d88f475c-288c-408b-bdaf-aafbdf219062"
os.makedirs(out_dir, exist_ok=True)
os.makedirs(artifact_dir, exist_ok=True)

# Load base logo
base_logo_path = r"c:\krina\time-calculator\assets\icons\app_logo.png"
logo_img = Image.open(base_logo_path).convert("RGBA")

def save_image(img, filename):
    p1 = os.path.join(out_dir, filename)
    p2 = os.path.join(artifact_dir, filename)
    img.save(p1, "PNG")
    img.save(p2, "PNG")
    print(f"Saved {filename}: {img.size}")

# 1. App Icon (512x512)
icon_512 = Image.new("RGBA", (512, 512), (255, 255, 255, 0))
# Background rounded rectangle or circle
bg_icon = Image.new("RGBA", (512, 512), (30, 58, 138, 255)) # Deep blue #1E3A8A
mask = Image.new("L", (512, 512), 0)
draw_mask = ImageDraw.Draw(mask)
draw_mask.rounded_rectangle([0, 0, 512, 512], radius=110, fill=255)
icon_512.paste(bg_icon, (0, 0), mask)

# Overlay app logo centered
logo_resized = logo_img.resize((360, 360), Image.Resampling.LANCZOS)
icon_512.paste(logo_resized, (76, 76), logo_resized)
save_image(icon_512, "app_icon_512x512.png")

# 2. Feature Graphic (1024x500)
feat_w, feat_h = 1024, 500
feature_img = Image.new("RGBA", (feat_w, feat_h), (255, 255, 255, 255))
# Gradient background
bg_draw = ImageDraw.Draw(feature_img)
for y in range(feat_h):
    r = int(30 + (37 - 30) * y / feat_h)
    g = int(58 + (99 - 58) * y / feat_h)
    b = int(138 + (235 - 138) * y / feat_h)
    bg_draw.line([(0, y), (feat_w, y)], fill=(r, g, b, 255))

# Draw decorative shapes
bg_draw.ellipse([700, -100, 1150, 350], fill=(255, 255, 255, 20))
bg_draw.ellipse([-100, 200, 350, 650], fill=(255, 255, 255, 15))

# Feature graphic logo
feat_logo = logo_img.resize((180, 180), Image.Resampling.LANCZOS)
feature_img.paste(feat_logo, (80, 160), feat_logo)

# Feature graphic text
try:
    font_title = ImageFont.truetype("arial.ttf", 52)
    font_sub = ImageFont.truetype("arial.ttf", 26)
    font_badge = ImageFont.truetype("arialbd.ttf", 22)
except:
    font_title = font_sub = font_badge = ImageFont.load_default()

text_draw = ImageDraw.Draw(feature_img)
text_draw.text((290, 170), "Time Calculator", fill=(255, 255, 255, 255), font=font_title)
text_draw.text((290, 240), "Add & Subtract Days, Hours, Minutes, Seconds", fill=(226, 232, 240, 255), font=font_sub)

# Draw Pill Badge
badge_bg = Image.new("RGBA", (450, 48), (255, 255, 255, 30))
badge_mask = Image.new("L", (450, 48), 0)
ImageDraw.Draw(badge_mask).rounded_rectangle([0, 0, 450, 48], radius=24, fill=255)
feature_img.paste(badge_bg, (290, 290), badge_mask)

badge_draw = ImageDraw.Draw(feature_img)
badge_draw.text((310, 302), "Fast • Offline • Precise • No Ads", fill=(255, 255, 255, 255), font=font_badge)

save_image(feature_img, "feature_graphic_1024x500.png")

# Function to draw phone screenshot (1080x2400)
def draw_phone_screenshot(filename, header_title, mode_label, val1, val2, result_vals, result_summary, is_sub=False):
    sw, sh = 1080, 2400
    scr = Image.new("RGBA", (sw, sh), (241, 245, 249, 255))
    d = ImageDraw.Draw(scr)
    
    # Status bar
    d.rectangle([0, 0, sw, 90], fill=(255, 255, 255, 255))
    try:
        f_status = ImageFont.truetype("arialbd.ttf", 32)
        f_appbar = ImageFont.truetype("arialbd.ttf", 44)
        f_card_t = ImageFont.truetype("arialbd.ttf", 48)
        f_card_desc = ImageFont.truetype("arial.ttf", 32)
        f_label = ImageFont.truetype("arialbd.ttf", 36)
        f_val = ImageFont.truetype("arialbd.ttf", 42)
        f_btn = ImageFont.truetype("arialbd.ttf", 38)
    except:
        f_status = f_appbar = f_card_t = f_card_desc = f_label = f_val = f_btn = ImageFont.load_default()

    d.text((60, 24), "9:41", fill=(15, 23, 42, 255), font=f_status)
    
    # App Bar
    d.rectangle([0, 90, sw, 220], fill=(255, 255, 255, 255))
    app_logo_small = logo_img.resize((70, 70), Image.Resampling.LANCZOS)
    scr.paste(app_logo_small, (50, 120), app_logo_small)
    d.text((140, 130), "Time Calculator", fill=(15, 23, 42, 255), font=f_appbar)
    d.ellipse([960, 130, 1020, 190], outline=(37, 99, 235, 255), width=4)
    d.text((982, 140), "i", fill=(37, 99, 235, 255), font=f_status)

    # Top Banner Card
    d.rounded_rectangle([40, 260, 1040, 520], radius=24, fill=(30, 58, 138, 255))
    d.text((80, 290), header_title, fill=(255, 255, 255, 255), font=f_card_t)
    d.text((80, 360), "Calculate total duration by adding or subtracting\ntwo time sets (Days, Hours, Minutes, Seconds).", fill=(226, 232, 240, 255), font=f_card_desc)

    # Main Card Container
    d.rounded_rectangle([40, 560, 1040, 2150], radius=24, fill=(235, 236, 239, 255), outline=(203, 213, 225, 255), width=3)
    
    # Column Labels
    cols = ["Day", "Hour", "Minute", "Second"]
    for i, col in enumerate(cols):
        cx = 70 + i * 240
        d.text((cx + 50, 600), col, fill=(15, 23, 42, 255), font=f_label)

    # Row 1 Inputs
    for i, v in enumerate(val1):
        x = 70 + i * 240
        d.rounded_rectangle([x, 670, x + 200, 780], radius=12, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=3)
        d.text((x + 70, 700), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Radio options
    d.rounded_rectangle([320, 830, 760, 930], radius=50, fill=(255, 255, 255, 255), outline=(203, 213, 225, 255), width=3)
    # Add option
    d.ellipse([350, 855, 400, 905], outline=(37, 99, 235, 255) if not is_sub else (100, 100, 100, 255), width=4)
    if not is_sub:
        d.ellipse([365, 870, 385, 890], fill=(37, 99, 235, 255))
    d.text((415, 855), "Add+", fill=(30, 58, 138, 255) if not is_sub else (71, 85, 105, 255), font=f_label)

    # Subtract option
    d.ellipse([560, 855, 610, 905], outline=(37, 99, 235, 255) if is_sub else (100, 100, 100, 255), width=4)
    if is_sub:
        d.ellipse([575, 870, 595, 890], fill=(37, 99, 235, 255))
    d.text((625, 855), "Subtract–", fill=(30, 58, 138, 255) if is_sub else (71, 85, 105, 255), font=f_label)

    # Row 2 Inputs
    for i, v in enumerate(val2):
        x = 70 + i * 240
        d.rounded_rectangle([x, 980, x + 200, 1090], radius=12, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=3)
        d.text((x + 70, 1010), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Equals Circle
    d.ellipse([490, 1130, 590, 1230], fill=(30, 41, 59, 255))
    d.text((520, 1145), "=", fill=(255, 255, 255, 255), font=f_appbar)

    # Row 3 Result Fields
    for i, v in enumerate(result_vals):
        x = 70 + i * 240
        d.rounded_rectangle([x, 1270, x + 200, 1380], radius=12, fill=(255, 255, 255, 255), outline=(148, 163, 184, 255), width=3)
        d.text((x + 60, 1300), str(v), fill=(15, 23, 42, 255), font=f_val)

    # Result Summary Banner
    d.rounded_rectangle([80, 1430, 1000, 1570], radius=20, fill=(240, 253, 244, 255), outline=(134, 239, 172, 255), width=3)
    d.text((120, 1475), result_summary, fill=(21, 128, 61, 255), font=f_label)

    # Buttons
    d.rounded_rectangle([180, 1650, 580, 1780], radius=20, fill=(75, 123, 31, 255))
    d.text((270, 1690), "Calculate ▶", fill=(255, 255, 255, 255), font=f_btn)

    d.rounded_rectangle([620, 1650, 900, 1780], radius=20, fill=(138, 138, 138, 255))
    d.text((710, 1690), "Clear", fill=(255, 255, 255, 255), font=f_btn)

    # Decorative bottom footer text
    d.text((340, 2050), "Emperor Smart Solutions", fill=(148, 163, 184, 255), font=f_card_desc)

    save_image(scr, filename)

# Draw 3 screenshots
draw_phone_screenshot(
    "phone_screenshot_1.png",
    "Time Addition",
    "Add+",
    [2, 14, 45, 30],
    [1, 12, 20, 45],
    [4, 3, 6, 15],
    "Result: 4 Days, 3 Hours, 6 Mins, 15 Secs",
    is_sub=False
)

draw_phone_screenshot(
    "phone_screenshot_2.png",
    "Time Subtraction",
    "Subtract–",
    [5, 10, 0, 0],
    [2, 15, 30, 0],
    [2, 18, 30, 0],
    "Result: 2 Days, 18 Hours, 30 Mins, 0 Secs",
    is_sub=True
)

# Screenshot 3: About & Legal Screen
def draw_about_screenshot(filename):
    sw, sh = 1080, 2400
    scr = Image.new("RGBA", (sw, sh), (244, 246, 249, 255))
    d = ImageDraw.Draw(scr)
    
    try:
        f_appbar = ImageFont.truetype("arialbd.ttf", 44)
        f_sec = ImageFont.truetype("arialbd.ttf", 36)
        f_item = ImageFont.truetype("arialbd.ttf", 40)
        f_sub = ImageFont.truetype("arial.ttf", 32)
    except:
        f_appbar = f_sec = f_item = f_sub = ImageFont.load_default()

    # App Bar
    d.rectangle([0, 90, sw, 220], fill=(255, 255, 255, 255))
    d.text((80, 130), "About", fill=(30, 41, 59, 255), font=f_appbar)

    # Section 1
    d.text((60, 260), "LEGAL & GOVERNANCE", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([40, 310, 1040, 510], radius=24, fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=3)
    d.text((100, 360), "Privacy Policy", fill=(15, 23, 42, 255), font=f_item)
    d.text((100, 420), "Read full data safety practices & privacy policy", fill=(100, 116, 139, 255), font=f_sub)

    # Section 2
    d.text((60, 560), "CONNECT WITH US", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([40, 610, 1040, 1130], radius=24, fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=3)
    
    items = [
        ("Instagram", "Follow Emperor Smart Solutions"),
        ("LinkedIn", "Follow Emperor Smart Solutions"),
        ("Contact Us", "+91 63543 51080")
    ]
    for i, (t, s) in enumerate(items):
        y = 650 + i * 160
        d.text((100, y), t, fill=(15, 23, 42, 255), font=f_item)
        d.text((100, y + 55), s, fill=(100, 116, 139, 255), font=f_sub)
        if i < 2:
            d.line([(100, y + 120), (1000, y + 120)], fill=(241, 245, 249, 255), width=3)

    # Section 3
    d.text((60, 1180), "DEVELOPER", fill=(100, 116, 139, 255), font=f_sec)
    d.rounded_rectangle([40, 1230, 1040, 1550], radius=24, fill=(255, 255, 255, 255), outline=(226, 232, 240, 255), width=3)
    d.text((100, 1280), "Emperor Smart Solutions", fill=(15, 23, 42, 255), font=f_item)
    d.text((100, 1350), "Emperor Smart Solutions develops software, mobile\napplications, digital products, and utility applications.", fill=(100, 116, 139, 255), font=f_sub)

    d.text((380, 1750), "Time Calculator v1.0.0", fill=(148, 163, 184, 255), font=f_sub)
    save_image(scr, filename)

draw_about_screenshot("phone_screenshot_3.png")
print("All Play Store assets generated successfully!")
