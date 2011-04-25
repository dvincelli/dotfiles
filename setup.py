try:
    from setuptools import setup, find_packages
except ImportError:
    from ez_setup import use_setuptools
    use_setuptools()
    from setuptools import setup, find_packages

setup(
    name='dotfiles',
    version='0.0.1',
    description='These are my pesonal dotfiles',
    url='http://longword.ca/',
    install_requires=[
        "virtualenv",
        "virtualenvwrapper",
        "setuptools-git",
        "nose",
        "pyflakes",
        "pygments",
        "rope",
        "pylint",
        "ipython",
        "pysmell",
        "pep8"
    ],
    packages=find_packages(exclude=['ez_setup'])
)
