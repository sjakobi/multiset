import Data.MultiSet

import           Data.Monoid (Sum)
import           Test.QuickCheck (Arbitrary(..))
import qualified Test.QuickCheck.Classes
import qualified Test.QuickCheck.Checkers
import           Test.QuickCheck.Checkers (EqProp(..))
import qualified Test.Tasty
import qualified Test.Tasty.QuickCheck

main = Test.Tasty.defaultMain
  (uncurry Test.Tasty.QuickCheck.testProperties
    (Test.QuickCheck.Classes.foldable (undefined :: MultiSet (Integer, Integer, Sum Integer, Integer, Integer))))

instance (Arbitrary a, Ord a) => Arbitrary (MultiSet a) where
  arbitrary = fromList <$> arbitrary

instance Eq a => EqProp (MultiSet a) where
  (=-=) = Test.QuickCheck.Checkers.eq

instance Eq a => EqProp (Sum a) where
  (=-=) = Test.QuickCheck.Checkers.eq

instance EqProp Integer where
  (=-=) = Test.QuickCheck.Checkers.eq
