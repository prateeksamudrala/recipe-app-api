"""Tests for the calc app."""


from django.test import SimpleTestCase  # type: ignore

from app import calc

class CalcTests(SimpleTestCase):

    def test_add_numbers(self):
        res = calc.add(3, 2)
        self.assertEqual(res, 5)

    def test_subtract(self):
        res = calc.subtract(5,3)
        self.assertEqual(res, 2)

    # def test_multiply(self):
    #     self.assertEqual(calc.multiply(2, 3), 6)

    # def test_divide(self):
    #     self.assertEqual(calc.divide(6, 3), 2)

