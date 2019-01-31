/* See LICENSE file for copyright and license details. */
#include "X11/XF86keysym.h"

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "mono:pixelsize=12:antialias=true:autohint=true" };
static const char dmenufont[]       = "mono:pixelsize=12:antialias=true:autohint=true";
static const char col_gray1[]       = "#282828";
static const char col_gray2[]       = "#504945";
static const char col_gray3[]       = "#ebdbb2";
static const char col_gray4[]       = "#fe8019";
static const char col_gray5[]       = "#928374";
static const char col_black[]       = "#1d2021";
static const char *colors[][3]      = {
/*               fg         bg         border   */
    [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_black, col_gray5 },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title    tags mask  iscentered isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       1 << 4,     1,       1,      -1 },
	{ "Skype",    NULL,       NULL,       1 << 1,     0,       0,      -1 },
	{ "linphone", NULL,       NULL,            0,     1,       1,      -1 },
	{ "webitel-phone",   NULL, NULL,           0,     1,       1,      -1 },
	{ "TelegramDesktop", NULL, NULL,      1 << 1,     0,       0,      -1 },
	{ NULL,       NULL,     "tmuxdd",          0,     1,       1,      -1 },
	{ NULL,       NULL,    "pamixer",          0,     1,       1,      -1 },
	{ NULL,       NULL,    "ncmpcpp",          0,     1,       1,      -1 },
	{ NULL, "transmission-gtk", NULL,          0,     0,       1,      -1 },
	{ NULL,     NULL, "video0 - mpv",          0,     0,       1,      -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_black, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "xterm", NULL };
static const char *vold[] = { "pamixer", "-d", "5", NULL };
static const char *volu[] = { "pamixer", "-i", "5", NULL };
static const char *mute[] = { "pamixer", "-t", NULL };
static const char *micm[] = { "pamixer", "--default-source", "-t", NULL };
static const char *play[] = { "mpc", "toggle", NULL };
static const char *next[] = { "mpc", "next", NULL };
static const char *prev[] = { "mpc", "prev", NULL };
static const char *stop[] = { "mpc", "stop", NULL };
static const char *bklu[] = { "xbacklight", "-steps", "1", "-time", "0", "-inc", "5", NULL };
static const char *bkld[] = { "xbacklight", "-steps", "1", "-time", "0", "-dec", "5", NULL };
static const char *prts[] = { "screenpng", "Pictures/screenshots/", NULL };
static const char *prtw[] = { "screenpng", "-s", "Pictures/screenshots/", NULL };
static const char *brws[] = { "opensurf", NULL };
static const char *disp[] = { "displayselect", NULL };
static const char *dwmr[] = { "dwmrun", NULL };
static const char *dwml[] = { "dwmlock", NULL };
static const char *drec[] = { "dmenurecord", NULL };
static const char *tmux[] = { "dwmruntmux", NULL };
static const char *dmopen[] = { "dmenuopen", NULL };
static const char *webcam[] = { "webcam", NULL };
static const char *ncmpcpp[] = { "dwmrunmpc", NULL };
static const char *pamixer[] = { "dwmrunpamixer", NULL };
static const char *telegram[] = { "telegram-desktop", NULL };
static const char *savexclip[] = { "savexclip", NULL };


static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_s,      togglesticky,   {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = savexclip } },
	{ MODKEY|ShiftMask,             XK_t,      spawn,          {.v = telegram } },
	{ MODKEY|ShiftMask,             XK_b,      spawn,          {.v = brws } },
	{ MODKEY,                       XK_u,      spawn,          {.v = tmux } },
	{ MODKEY,                       XK_r,      spawn,          {.v = dwmr } },
	{ MODKEY|ShiftMask,             XK_l,      spawn,          {.v = dwml } },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = pamixer } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = ncmpcpp } },
	{ MODKEY|ShiftMask,             XK_o,      spawn,          {.v = dmopen } },
	{ MODKEY|ShiftMask,             XK_w,      spawn,          {.v = webcam } },
    {0,                 XF86XK_AudioLowerVolume,    spawn,          {.v = vold } },
    {0,                 XF86XK_AudioRaiseVolume,    spawn,          {.v = volu } },
    {0,                 XF86XK_AudioMute,           spawn,          {.v = mute } },
    {0,                 XF86XK_AudioMicMute,        spawn,          {.v = micm } },
    {0,                 XF86XK_AudioPlay,           spawn,          {.v = play } },
    {0,                 XF86XK_AudioNext,           spawn,          {.v = next } },
    {0,                 XF86XK_AudioPrev,           spawn,          {.v = prev } },
    {0,                 XF86XK_AudioStop,           spawn,          {.v = stop } },
    {0,                 XF86XK_MonBrightnessUp,     spawn,          {.v = bklu } },
    {0,                 XF86XK_Display,             spawn,          {.v = disp } },
    {0,                 XF86XK_Explorer,            spawn,          {.v = dmenucmd } },
    {0,                 XK_Print,                   spawn,          {.v = prts } },
    {MODKEY|ShiftMask,  XK_Print,                   spawn,          {.v = prtw } },
    {MODKEY,            XK_Print,                   spawn,          {.v = drec } },
{0, XF86XK_MonBrightnessDown, spawn, {.v = bkld } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = pamixer } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

