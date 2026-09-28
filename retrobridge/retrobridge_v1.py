#!/usr/bin/env python3
"""RetroBridge V1.1 - 8-Bit Edition (publication-safe frontend)."""
import tkinter as tk
import subprocess, os, socket, shutil

WIDTH, HEIGHT = 480, 320
BASE=os.environ.get(
    "RETROBRIDGE_HOME",
    os.path.dirname(os.path.abspath(__file__))
)
LAUNCHERS=os.path.join(BASE, "launchers")
APPLE1_PROGRAMS=os.path.join(BASE, "programs", "apple1")
MAINTENANCE=os.path.join(BASE, "system", "maintenance")

BLACK="#050505"; WHITE="#E8E8E8"; MID="#282828"; GRAY="#777777"
GREEN="#39FF88"; AMBER="#FFB000"; CYAN="#40E0FF"; C64LIGHT="#A8B3FF"

MACHINES={
"apple1":("1976","APPLE-1",GREEN,"MOS 6502 / ~1 MHz / 4 KB"),
"trs80":("1977","TRS-80 MODEL I",WHITE,"Z80 / 1.77 MHz / LEVEL II BASIC"),
"apple2":("1977","APPLE II",AMBER,"MOS 6502 / ~1 MHz / 48 KB"),
"ibmpc":("1981","IBM PC",CYAN,"8088 / 4.77 MHz / DOS"),
"c64":("1982","COMMODORE 64",C64LIGHT,"MOS 6510 / ~1 MHz / 64 KB")
}

class RetroBridge:
    def __init__(self,root):
        self.root=root
        root.title("RetroBridge V1.1")
        root.configure(bg=BLACK); root.geometry("480x320+0+0")
        root.attributes("-fullscreen",True)
        root.bind("<Escape>",lambda e:self.home())
        root.bind("<F12>",lambda e:self.home())
        self.home()

    def clear(self):
        for w in self.root.winfo_children(): w.destroy()

    def label(self,p,text,fg=WHITE,size=10,bold=False,**kw):
        return tk.Label(p,text=text,fg=fg,bg=BLACK,
            font=("DejaVu Sans Mono",size,"bold" if bold else "normal"),**kw)

    def button(self,p,text,cmd,accent=GREEN,width=20,size=10):
        outer=tk.Frame(p,bg=accent,padx=2,pady=2)
        tk.Button(outer,text=text,command=cmd,fg=accent,bg=BLACK,
            activeforeground=BLACK,activebackground=accent,
            font=("DejaVu Sans Mono",size,"bold"),relief=tk.FLAT,
            bd=0,width=width,pady=5).pack()
        return outer

    def tiny(self,p,text,cmd,accent=GREEN):
        return tk.Button(p,text=text,command=cmd,fg=accent,bg=MID,
            activeforeground=BLACK,activebackground=accent,
            font=("DejaVu Sans Mono",8,"bold"),relief=tk.FLAT,bd=0,padx=7,pady=3)

    def bar(self,title,right="",accent=GREEN):
        f=tk.Frame(self.root,bg=accent,height=28); f.pack(fill=tk.X); f.pack_propagate(False)
        i=tk.Frame(f,bg=BLACK); i.pack(fill=tk.BOTH,expand=True,padx=2,pady=2)
        self.label(i," "+title,accent,10,True).pack(side=tk.LEFT)
        if right:self.label(i,right+" ",accent,9,True).pack(side=tk.RIGHT)

    def home(self):
        self.clear()
        self.label(self.root,"RETROBRIDGE",GREEN,25,True).pack(pady=(5,0))
        self.label(self.root,">> COMPUTING TIME MACHINE <<",AMBER,9,True).pack(pady=(0,5))
        tk.Frame(self.root,bg=GREEN,height=2).pack(fill=tk.X,padx=18,pady=(0,5))
        g=tk.Frame(self.root,bg=BLACK); g.pack()
        for row,col,key,short in [(0,0,"apple1","APPLE-1"),(0,1,"trs80","TRS-80"),
                                  (1,0,"apple2","APPLE II"),(1,1,"ibmpc","IBM PC")]:
            year,name,accent,_=MACHINES[key]
            o=tk.Frame(g,bg=accent,width=216,height=63); o.grid(row=row,column=col,padx=4,pady=3); o.grid_propagate(False)
            i=tk.Frame(o,bg=BLACK); i.pack(fill=tk.BOTH,expand=True,padx=2,pady=2)
            self.label(i,f"[ {year} ]",accent,8,True).pack(pady=(2,0))
            tk.Button(i,text=short,command=lambda k=key:self.machine(k),fg=accent,bg=BLACK,
                activeforeground=BLACK,activebackground=accent,font=("DejaVu Sans Mono",12,"bold"),
                relief=tk.FLAT,bd=0).pack(fill=tk.BOTH,expand=True)
        self.button(self.root,"1982  COMMODORE 64",lambda:self.machine("c64"),C64LIGHT,27,10).pack(pady=(5,2))
        f=tk.Frame(self.root,bg=BLACK); f.pack(side=tk.BOTTOM,fill=tk.X,pady=3)
        self.tiny(f,"[ ABOUT ]",self.about).pack(side=tk.LEFT,padx=6)
        self.label(f,"V1.1  8-BIT EDITION",GRAY,7).pack(side=tk.LEFT,expand=True)
        self.tiny(f,"[ SYSTEM ]",self.system).pack(side=tk.RIGHT,padx=6)

    def machine(self,key):
        self.clear(); year,name,accent,subtitle=MACHINES[key]
        self.bar(name,year,accent)
        self.label(self.root,">> "+subtitle+" <<",accent,8,True).pack(pady=(12,10))
        if key=="apple1":
            self.button(self.root,"ENTER COMPUTER",lambda:self.launch("apple1"),accent,24).pack(pady=8)
            self.label(self.root,"WOZ MONITOR  |  TYPE E000R FOR INTEGER BASIC",accent,7).pack(pady=3)
        else:
            self.button(self.root,"ENTER COMPUTER",lambda:self.launch(key),accent,24,11).pack(pady=(17,4))
        n=tk.Frame(self.root,bg=BLACK); n.pack(side=tk.BOTTOM,pady=10)
        self.tiny(n,"[ HISTORY ]",lambda:self.history(key),accent).pack(side=tk.LEFT,padx=5)
        self.tiny(n,"[ TIME MACHINE ]",self.home,accent).pack(side=tk.LEFT,padx=5)

    def history(self,key):
        year,name,accent,subtitle=MACHINES[key]; self.clear(); self.bar("SYSTEM ARCHIVE",year,accent)
        self.label(self.root,name,accent,16,True).pack(pady=(18,6))
        self.label(self.root,subtitle,WHITE,9,False).pack()
        self.label(self.root,"See docs and Hackaday build logs for the full historical and implementation story.",
                   WHITE,8,False,wraplength=410,justify=tk.CENTER).pack(padx=20,pady=25)
        self.button(self.root,"RETURN",lambda:self.machine(key),accent,14,9).pack(side=tk.BOTTOM,pady=9)

    def loading(self,key):
        self.clear(); year,name,accent,_=MACHINES[key]
        self.label(self.root,year,accent,30,True).pack(pady=(45,4))
        self.label(self.root,"LOADING "+name+"...",accent,12,True).pack(pady=5)
        self.root.update(); self.root.after(500)

    def run(self,cmd):
        self.root.withdraw()
        try: subprocess.run(cmd)
        except Exception as e: print("RetroBridge launch error:",e)
        self.root.deiconify(); self.root.lift(); self.root.focus_force()

    def launch(self,key):
        paths={"apple1":"launch_apple1.sh","trs80":"launch_trs80.sh","apple2":"launch_apple2.sh",
               "ibmpc":"launch_ibmpc.sh","c64":"launch_c64.sh"}
        self.loading(key); self.run([f"{LAUNCHERS}/{paths[key]}"]); self.machine(key)

    def apple1(self,wrapper):
        self.loading("apple1"); self.run(["python3",f"{BASE}/{wrapper}"]); self.machine("apple1")

    def apple1_library(self):
        self.clear(); self.bar("APPLE-1 SOFTWARE","1976",GREEN)
        fs=sorted(f for f in os.listdir(APPLE1_PROGRAMS) if f.lower().endswith(".bas")) if os.path.isdir(APPLE1_PROGRAMS) else []
        c=tk.Frame(self.root,bg=BLACK); c.pack(expand=True)
        for f in fs[:6]:
            name=os.path.splitext(f)[0].replace("_"," ").replace("-"," ").upper()
            self.button(c,name,lambda x=f:self.apple1_program(x),GREEN,25,9).pack(pady=2)
        self.tiny(self.root,"[ BACK ]",lambda:self.machine("apple1"),GREEN).pack(side=tk.BOTTOM,pady=7)

    def apple1_program(self,f):
        self.loading("apple1")
        self.run(["python3",f"{BASE}/apple1_program.py",os.path.join(APPLE1_PROGRAMS,f)])
        self.apple1_library()

    def about(self):
        self.clear(); self.bar("RETROBRIDGE DATABASE","V1.1",GREEN)
        self.label(self.root,"FIVE COMPUTERS.\nSIX YEARS OF PERSONAL-COMPUTING HISTORY.\n\n"
                   "1976  APPLE-1\n1977  TRS-80 MODEL I\n1977  APPLE II\n"
                   "1981  IBM PC\n1982  COMMODORE 64\n\nMODERN HARDWARE. HISTORIC COMPUTING.",
                   WHITE,8,False,justify=tk.LEFT).pack(pady=22)
        self.button(self.root,"RETURN",self.home,GREEN,14,9).pack(side=tk.BOTTOM,pady=8)

    def system(self):
        self.clear(); self.bar("SYSTEM CONSOLE","V1.1",GREEN)
        try: host=socket.gethostname(); ip=subprocess.check_output(["hostname","-I"],text=True).strip()
        except Exception: host=ip="UNKNOWN"
        free=shutil.disk_usage("/").free/1024/1024/1024
        maint="ACTIVE" if os.path.exists(MAINTENANCE) else "OFF"
        self.label(self.root,f"SYSTEM STATUS\n-----------------------------\nHOST       : {host}\nIP         : {ip}\n"
                   f"FREE SPACE : {free:.1f} GB\nMAINT MODE : {maint}\n-----------------------------\n5 SYSTEMS ONLINE",
                   GREEN,8,False,justify=tk.LEFT).pack(anchor="w",padx=30,pady=(14,8))
        r=tk.Frame(self.root,bg=BLACK); r.pack()
        self.tiny(r,"MAINT ON",self.maint_on,AMBER).pack(side=tk.LEFT,padx=3)
        self.tiny(r,"MAINT OFF",self.maint_off,GREEN).pack(side=tk.LEFT,padx=3)
        self.button(self.root,"RETURN",self.home,GREEN,14,9).pack(side=tk.BOTTOM,pady=7)

    def maint_on(self):
        os.makedirs(os.path.dirname(MAINTENANCE),exist_ok=True); open(MAINTENANCE,"a").close(); self.system()
    def maint_off(self):
        try: os.remove(MAINTENANCE)
        except FileNotFoundError: pass
        self.system()

root=tk.Tk()
RetroBridge(root)
root.mainloop()
