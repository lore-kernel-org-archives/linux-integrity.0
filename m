Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124164;
	b=LzwYxEO/SJ6Vb1scMPjwhXBh0NeJU3sgiB55Fyxc5lwS1ioa6gzIWm4sEBDU2he06Ev7
	 8mDuVmFFoE3iDCnGf+Wla7Zz1gnhcC/QEap1qxomFv2rs2Yc2OevKLiI1mDk0seDJqbqF
	 0M0iDAvHAixy2o1IHQcf4zU2q1pOEtTO6MyDpV8xX6V/P2cSIw2gMrJMdhtDwK4PShQIf
	 locGg9ju9GeL9SxAk6X2uXliDHqtYWViKEFl0KfGCfX2YD9R9AptzhT7wryHm+iVcVvK4
	 E8P70Z9LMWsJP5I7osQBErKJhV9fK2dWmw5nSKmQ0ksLw1ouZNcFQEAq8AogU/hHAsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124164;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Y5P2GKpu7VBJEzSn44WL0YA/mvmpD7LdS61drMFdbXg=;
	b=lgaOd8w4QTQqqKY4FJoXWOfrpPOsAsnIOPVEbDGfD+aU1nKUejA1wweTBTruwsljEaIh
	 xsK+aPDjMbGTn2cZH+WnB1Dap0DkzYb//Jv8SnW7pYOUZIKVkhwr5oLgF/xg/9xJo4Tgg
	 kl6jqouCMLqiehFrXn+/3x3W1Y0pmTZapzohCs2jjZfq/iqF7hyDVZUdhB0qopT9CoyVD
	 3CApHfNYvRc2LygCZst3yirh8xcS3OOxJvQ9z9JOcDh1+kP86R7YZFTju/acKA467Tj0C
	 5Xqr1YqpateyxqzDNd3awDxgi/WOSGerwNgSh23dbFCyckBScaYC7vYPp/A0y7/xdpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KG/vhTxn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6150606A326;
	Thu, 19 Nov 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG/vhTxn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795124164;
	b=Pjo1VlZwnk+tJom1YPjQJMVD+sLYknwguV8LQRzVumdFvmC0Ts6ICd9kFCzwkz/N16P4
	 lifuMz35r+zh7iXUZr0J1at6yP6PR2J/or1TlOizVifofK1BCUetnZ/SYrpRCgdqtva9m
	 h6MxY+sad6WgxQufQ1EJcKjKcqhVxYCYGMh2tbxrIhJDGoBxW95ZctL52A5Yyh7caUC5X
	 bXq2ViTgUbjfW6ZP7uTAs4tiFApmibMqx69XiwAVxvEImipSfR1IzDAYozTvSPmw0jlEc
	 aK3HzOEFNbO6FlOItqPMICjDjT9PbX5XjhfVVHL2dNuU3wqiuYolhCF6pPoit3NHCyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124164;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Y5P2GKpu7VBJEzSn44WL0YA/mvmpD7LdS61drMFdbXg=;
	b=LR5NLSGRp3viOe5pvS4x6S+qAb0cKM+evINQ27pFE/wYTB23xiTKzmIFpqbeP6ghAPWK
	 CfhRZrJq33rVBJgtAu2apWn1Y3Fm6yw26cVdO3BbzEMLtqEb3AA8kfRcwgNn6DFM0NwGG
	 pOiQDjtW7mNY04hOBaQGP09O4oAeIE/cy+033s6yfyRazxOALZZuN0OxshqPmoPSsSwwn
	 p16brXQkQwnmROS10XtlC6J9407YJsCksMb7MCZVgLcNVfsvRVlJUMpShYyNZ7O0K5crK
	 aepDJTaEle2rKC90g+zMCm03qp5ABh3cxj6sXX/SDYyWuTDpn2+Aw/UjuVNkhVNyqBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B38181F000C0;
	Thu, 19 Nov 2026 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124164;
	bh=Y5P2GKpu7VBJEzSn44WL0YA/mvmpD7LdS61drMFdbXg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KG/vhTxnbDd29C5eqAx/65GPAsnqQp9mEx4Lt+Pn2oohZhZfNAAR6FZ7rOPzNqBs2
	 f6vQihYyWotJxPfTqJSoGSDPbCRteANYZeJFQOSbD9u6+A++/9EOj9VCdVolIteaKl
	 SofRqHYfLP2SRV39kDSSLQdXHwziHhfqMeAYqbeUa5kU07P1LO7NIxZ+cGFD8DYgDo
	 tiXvQAiusa4HLr7TvxzYycufuARmV+AfQsi/eIXaemM+MIEZ0c1evt+LdAzV8Xja1U
	 YhUSCGPs6ZRPlbgDRm4AGxzy8pgzbfiGPImmypbQ8MxQEnqEjZanbHC6b5i00e8Ene
	 drjUe5XxeGnDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1167C4003B;
	Thu, 19 Nov 2026 21:36:03 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 21:36:02 +0000
Subject: [PATCH v2] tpm: xen-tpmfront: fix use-after-free in
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
Message-Id: <20261119-xen-tpmfront-v2-1-e0e51c36360d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMFr/2oC/yXMQQqAIBBA0avIrBNygqCuEi1Kx5ogC7UQortnt
 XyL/y8I5JkCtOICTycH3lwGFgL0PLiJJJtswBJrpVQjEzkZ99X6zUU5GDvWZBBLVUFOdk+W07f
 r+t/hGBfS8X3AfT8KlDEPcAAAAA==
X-Change-ID: 20261119-xen-tpmfront-adfb6ed22013
To: jgg@ziepe.ca, jarkko@kernel.org
Cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org, 
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 jgross@suse.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795124161; l=2312;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=BY11RffTI2Z6vu+SneCIXHCnKpjtHLPKX9E8okznDNI=;
 b=nL3GacfXcsjDGtPEQ6wNUFWOk2SEu78HF49KcfEicxXZku5V/pW2Zu+VQLc6cFtjkwbD2vQgO
 Q3zVZYYJJ8GD0myaNnVwl85zP2+c+y7LAahq68DTiWThdSGdcrL3RJR
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

Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Changes in v2:
- Say that the stubdom vTPM backend never reaches this path, and don't
  ask for a stable backport (Juergen, Jarkko). No code change.

Compile tested on x86_64 (W=1, no new warnings). Not run with a Xen vTPM
backend.

v1: https://lore.kernel.org/xen-devel/20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com/
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




