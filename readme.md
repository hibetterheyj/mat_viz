# mat_viz

## python environment

```shell
conda create -n mat_viz python=3.7
conda activate mat_viz
conda update -n base -c defaults conda
```

- installed package

  ```shell
  conda install -c conda-forge jupyter
  conda install -c conda-forge ipywidgets
  python -m pip install numpy scipy matplotlib

  # to enable toc
  python -m pip install jupyter_contrib_nbextensions
  jupyter contrib nbextension install --user
  ```

- main function

  - `scipy.io.loadmat`: <https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.loadmat.html>
