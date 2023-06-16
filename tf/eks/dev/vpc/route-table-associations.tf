resource "aws_route_table_association" "rta_public" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.public.*.id,
    count.index,
  )
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "rta_database" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.database.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rta_cp" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.cp.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rta_svcs" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.svcs.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rta_worker" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.worker.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}
