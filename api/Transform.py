#!/usr/bin/env python

# Transform.py

import abc

class Transform(object):
    def __init__(self):
        pass

    @abc.abstractmethod
    def some_transform(self, **kwargs):
        #if "foo" in kwargs:
            # pass
        pass
