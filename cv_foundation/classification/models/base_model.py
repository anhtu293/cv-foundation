import torch
import torch.nn as nn
from typing import List


class BaseClassifier(nn.Module):
    def __init__(self, extractor: nn.Module, num_cls: int = 1000) -> None:
        """Base classifier

        Args:
            extractor (nn.Module): feature extraction module.
            num_cls (int): Number of classes.
        """
        super().__init__(self)
        self.extractor = extractor

        # classification head
        self.cls_head = self._build_cls_head(num_cls)

    def _build_cls_head(self, num_cls: int) -> nn.Module:
        """Build classification head
        """
        raise NotImplementedError("This method must be implemented in child class !")
