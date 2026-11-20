Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795148777;
	b=Lu6mhkY0NXq7iEbz4ELMO/nNfkb09NoABzmpycA6kZHHnhgUQ5lYcQ/gN3LiVO339CIq
	 yXf6DcxV0g9aGJ9VINjqe9jNKjQ+Zt3Xk72LyxFbkJJsNUAYthnjprvGy4KW5SGlGXycK
	 9oiU1hcKpA1n8EPmUmeVPi4ImYPYQ253CI+vPE/KpZFkBki9uJ9C/YhgNZfr92VmM3k7v
	 B/odE4AYI2L/ofLW8btmxKRYLEyvnu1gk6boDqvcUBTGkSfSywM+OvLAWDt/bQhNv9Q5x
	 yHysagpWxNW/+8QQ6/qp76eoOSIu6enxqXqwijKiskGs3OYcuxIUa/jCoKP38Zfng5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795148777;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qGC3Y4r7T20cQuoO4kDMAGiRID8rez9I459XavcFz0Y=;
	b=Z42cEHfzBtrqTS8w8MRXuaUfHtNqQ3wqiDmAhUXwNhBGgXAUWLFqOvDNnIK60MZmLVfK
	 jA8qV9yF24a/2PdXw5b6M/7ydpnS05ra5n+x2vLm9kR9rcCoC3ib96x/gh30ZtCQSfXmv
	 DVp49bf7r2JV2a2w1UoSmqnPoQy8c1LPQaYalYvtQhpeSjSbj3X9mkSdnaXII7LZOjYeD
	 GX6KK6uS1YQJj+6VQMFvZP60XYvuebaNmjrYyiAHdDtvOkN78klEpLv9jSqYcB6TghOZr
	 /gp9yiUZ5tcKguQaS1SHpqQfwlAP4dxgp78otSlmLnQFbFgMpUFz/JVdKzKD5Z013lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLjfhC7S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51F606A320;
	Fri, 20 Nov 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLjfhC7S
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795148777;
	b=KrVB86G+VLdQ5lvzKGgZ7mRSE7rBgjZJG3FD2Yayw+ObSZcjpALDLm9nWy6SqYSnd4yR
	 kDTXG/0vU2lYcNH7AB6pwfD05yVA0Z1vW4zuvMraGV9sjQwvQXkz010iuNrnCLrvLrFUH
	 qO2UNdbfIEX14j31eBOsx5xIKwQL/l8BlBq/EX4BYrq6DttldvRksKC51kqbtdioGwaNh
	 b/EiraX4L5mgRkzSlhk+U7Yb0W4tvmD4Dbw0CJkHbpWboolwqARKmrNZ2fuOWCuYyivgv
	 2JYbRo9etajRRZnRuATlmJIuRpCRh22Yk60orvc6OWE7hW9AmZhaVVSfEHUH3AADSsw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795148777;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qGC3Y4r7T20cQuoO4kDMAGiRID8rez9I459XavcFz0Y=;
	b=KBdHxITGeT/rH2lX2xEroxM+gSZ3kt7GpvvCwpPjedp9MCRvdcXVgC1HEU6dJfJe+Htr
	 RZrfBa4m61HZJux+H1Q1jX5KM03GbmFgrCCioXq4A/HXMlGir87QyT/wpqRURN6QZ8Ndx
	 +kKHdlps4kuLQOXQTqNpcbsHp1lPzw9DzgZtLkV2uJwI7E7RU2ywvUyo0k8t5hM3DJmYf
	 RekJ43CFVLw9DNhXfOVVGFR2IFAvOqWF1Ot+ofg8FK2NNSnY5CW6y7KhRhhFeoG3do9m9
	 cGMJSH+rYqlJVRckWciXvX7TY4uaGBXYD4ikGdvaQp+HqkSGQ4FR1w8shrF1rLdUrfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E6E371F000C4;
	Fri, 20 Nov 2026 04:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795148777;
	bh=qGC3Y4r7T20cQuoO4kDMAGiRID8rez9I459XavcFz0Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VLjfhC7SSy6ue0An+s1KZaFSAYL2GE1B5ANxEU2fuAk5sUVy9OlIUPBr65FL+6hFQ
	 SHIZxG3xhQeNRoyHWgygo6V9G/C9O0Dk06CvfG8N7V9iZYboxvJxfKzqzJQg4e5PdO
	 yaJ4pAgrUaqMyVXQYTy6HWXHhZN+FUhiSttzCyA6NiJu/2lM3kaRHhOe07d86Vn6Fv
	 FAoudsrpuInRiQLkQ6YwKNWgQxczA6UTa2oqZbrqH+weN79VOHmbN1vS/3pvC2pn22
	 cqjkSqO4UfGcVCGDNPQ4RePI6Z7OGVUvjWs7cgDDZqdUoyN1EeUQG7bpLQPHsnX2XZ
	 c7I5RT7CYvgRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 64DDE495A0;
	Fri, 20 Nov 2026 04:26:16 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 04:26:16 +0000
Subject: [PATCH v3] tpm: xen-tpmfront: fix use-after-free in
 backend_changed()
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-xen-tpmfront-v3-1-3ea2e3fd8611@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOfL/2oC/yXMQQ5AMBBA0avIrDWpqi5cRSwYU0aipC2RiLsrl
 m/x/wWBPFOAOrvA08GBV5dQ5hng1LmRBA/JoKQyRaGkOMmJuC3Wry4K1Eiy16hMZSElmyfL57d
 r2t9h72fC+D7gvh/w/tYMcAAAAA==
X-Change-ID: 20261120-xen-tpmfront-c4ce0b4c265f
To: jgg@ziepe.ca, jarkko@kernel.org
Cc: sstabellini@kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, 
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795148775; l=2391;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=y48N31ZkViOWzWpWm3teQZk54JRgePEMfCs5wUrfGDI=;
 b=0aGMxum0hOy9buIFYkF9KMKvvK+7gQ4d4pH6piRdWeijez31/TgCv47CxSTssPFrw8PGRVo+T
 kKvn2MY1G2CBNupEha6M6Hdr1X/7rI0n8vlpeQPUJ7NaoZ9BDx6Cw+K
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

When the backend moves to Closing or Closed, backend_changed()
unregisters the device and then keeps using it:

	device_unregister(&dev->dev);
	xenbus_frontend_closed(dev);

The xenbus watch callback that calls backend_changed() does not hold a
reference to the device. The tpm_chip registered by xen-tpmfront has dev
as its parent and holds a reference to it, but tpmfront_remove() drops
that reference when it unregisters the chip. So device_unregister() can
release the last reference and free the xenbus_device, and
xenbus_frontend_closed(dev) then accesses freed memory.

The stubdom based vTPM backend, the only one in use today, never
switches to Closing or Closed, so this path is not reached with it. It
is reached with any backend that follows the normal xenbus state
machine on shutdown.

Take a temporary reference before unregistering and drop it after
xenbus_frontend_closed(). This keeps dev alive for the last access and
keeps the existing order, in which TPM operations are stopped before
the frontend is marked Closed.

Found with a static analysis tool and checked by hand.

Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Changes in v3:
- Drop the Fixes tag (Jarkko). No code change.

Changes in v2:
- Say that the stubdom vTPM backend never reaches this path, and don't
  ask for a stable backport (Juergen, Jarkko). No code change.

Compile tested on x86_64 (W=1, no new warnings). Not run with a Xen vTPM
backend.

v2: https://lore.kernel.org/all/20261119-xen-tpmfront-v2-1-e0e51c36360d@gmail.com/
v1: https://lore.kernel.org/all/20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com/
---
 drivers/char/tpm/xen-tpmfront.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 3c0cce57c4ae..1be925cca535 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -397,8 +397,11 @@ static void backend_changed(struct xenbus_device *dev,
 
 	case XenbusStateClosing:
 	case XenbusStateClosed:
+		/* device_unregister() can drop the last reference to dev */
+		get_device(&dev->dev);
 		device_unregister(&dev->dev);
 		xenbus_frontend_closed(dev);
+		put_device(&dev->dev);
 		break;
 	default:
 		break;




