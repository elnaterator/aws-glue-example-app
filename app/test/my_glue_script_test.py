import unittest
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType
from ..src.my_glue_script import transform_data


class TestMyGlueScript(unittest.TestCase):
    def setUp(self):
        self.spark = (
            SparkSession.builder.master("local[2]")
            .appName("MyGlueScriptTest")
            .getOrCreate()
        )

        schema = StructType(
            [
                StructField("first_name", StringType(), True),
                StructField("last_name", StringType(), True),
            ]
        )

        self.test_data = self.spark.createDataFrame(
            [
                ("John", "Doe"),
                ("Jane", "Campbell"),
                ("Alice", "Johnson"),
                ("Bob", "Bobson"),
            ],
            schema,
        )

    def test_transform_data(self):
        sorted_data = transform_data(self.test_data)
        self.assertEqual(sorted_data.first()["first_name"], "Alice")

    def tearDown(self):
        self.spark.stop()


if __name__ == "__main__":
    unittest.main()
