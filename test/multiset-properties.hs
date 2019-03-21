import           Data.Monoid              (Sum(..))
import           Data.MultiSet
import           Test.QuickCheck          (Arbitrary(..), Gen)
import qualified Test.QuickCheck.Classes
import qualified Test.QuickCheck.Checkers
import           Test.QuickCheck.Checkers (EqProp(..))
import qualified Test.Tasty
import qualified Test.Tasty.QuickCheck

main = Test.Tasty.defaultMain $ Test.Tasty.testGroup "Instances"
    [ batchToTree $ Test.QuickCheck.Classes.ord
        (const (arbitrary :: Gen (MultiSet Integer)))
    , batchToTree $ Test.QuickCheck.Classes.semigroup
        (undefined :: (MultiSet Integer, Int))
    , batchToTree $ Test.QuickCheck.Classes.monoid
        (undefined :: MultiSet Integer)
    , batchToTree $ Test.QuickCheck.Classes.foldable
        (undefined :: MultiSet (Integer, Integer, [Integer], Integer, Integer))
    ]
  where
    batchToTree :: Test.QuickCheck.Checkers.TestBatch -> Test.Tasty.TestTree
    batchToTree = uncurry Test.Tasty.QuickCheck.testProperties

instance (Arbitrary a, Ord a) => Arbitrary (MultiSet a) where
  arbitrary = fromList <$> arbitrary

instance Eq a => EqProp (MultiSet a) where
  (=-=) = Test.QuickCheck.Checkers.eq
