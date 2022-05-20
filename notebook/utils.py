import matplotlib.pyplot as plt

def plot_variables(
    mat_data: dict,
    vars: list,
    xlims: list = None,
    ylims: list = None,
    ylabel: str = None,
    title: str = None,
    fig_sz: tuple = (8, 3),
    style = None,
) -> None:
    if style is None:
        plt.style.use('ggplot')
    fig, ax = plt.subplots(figsize=fig_sz)
    for var in vars:
        var_data = mat_data[var]
        time = var_data[0][0][6]
        vals = var_data[0][0][7][0][0][0]
        var_label = var.split('_')[-2]
        ax.plot(time, vals, label=var_label)
    ax.legend()
    ax.set_xlabel("Time (s)")

    if xlims is not None:
        ax.set_xlim(xlims)
    if ylims is not None:
        ax.set_ylim(ylims)
    if title is not None:
        ax.set_title(title)
    if ylabel is not None:
        ax.set_ylabel(ylabel)

    fig.set_dpi(150.0)
    fig.tight_layout()
    plt.show()

def plot_axay(
    mat_data: dict,
    xlims: list = None,
    ylims: list = None,
    fig_sz: tuple = (8, 3),
    style = None,
) -> None:
    vars = ['dbc_Dr_00_CCFb_03_ax_02', 'dbc_Dr_00_CCFb_03_ay_03']
    plot_variables(
        mat_data = mat_data,
        vars = vars,
        xlims = xlims,
        ylims = ylims,
        title = 'Acc changes alone the time',
        ylabel = 'Accleration ($m/s^2$)',
        fig_sz = fig_sz,
        style = style,
    )

def plot_wz(
    mat_data: dict,
    xlims: list = None,
    ylims: list = None,
    fig_sz: tuple = (8, 3),
    style = None,
) -> None:
    vars = ['dbc_Dr_00_CCFc_04_wz_03']
    plot_variables(
        mat_data = mat_data,
        vars = vars,
        xlims = xlims,
        ylims = ylims,
        title = 'Rotation speed changes alone the time',
        ylabel = 'Rotation speed ($rad/s$)',
        fig_sz = fig_sz,
        style = style,
    )

def plot_bat_tem_max(
    mat_data: dict,
    xlims: list = None,
    ylims: list = None,
    fig_sz: tuple = (8, 3),
    style = None,
) -> None:
    vars = ['dbc_Dr_00_BMSb_01_BatTemMax_02']
    plot_variables(
        mat_data = mat_data,
        vars = vars,
        xlims = xlims,
        ylims = ylims,
        title = 'Max Battery Temperature changes alone the time',
        ylabel = 'Temperature ($^{\circ}$C)',
        fig_sz = fig_sz,
        style = style,
    )
