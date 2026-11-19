Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087235;
	b=uFWChf34zwVtiXCg3KnzxJf/wAYIEk5mLsfYqeaW4c7YAdTFsxoCGvgf4yKFzbRoObT9
	 QusvzwbW649AQsKLU0TIjoXaFNJKbckRwRCvCrLLfYo/Sug1m3CtC4330J0ieMwmLNOu+
	 uVNQxHTlvQ9YWa4p1DX9HUUKlGNk8f0vnO4WHJQ8ggM5O5P5DEA9myqXUI674TJk8rsJt
	 fbhvDtxbwRYnajo/yKRV50FRwv83MGoGeDotBiqVEcCjxSkPTf+rpGu61WZRVL9K8mBa0
	 IEtOmEWAITN7+tqzVcdKtOcZuUBNUlTCH9UmWRVe17+s5R9qqFnD+TuplxrVFA732zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087235;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=HxTh5QEOxLCvDecXq3k9qIqzQesIJHxSTR2i+oLJhDQ=;
	b=HUhcmNFI/DIvM6pnAYcFRk+5E21fQfsBQ3ssd6Alvga747P5y728QRktGhyalFt/Izxg
	 h5jxeZyb/10jfRG0bU6qUk/A7wFN2BhAinTHrprONjKGj8eqHTNS8K6hFVq9LVh7Umyzl
	 /3hi2wUxEPGfx/0t99q+pMTqTqsc7CucJtkB8CTZnfIRzBGmQG7EsAQsSfvXnJkO7S1dE
	 SQHI4UwE/A1QMP8PWdlkL4AQwo0NArmapIwn51go0mkF9U7sawHxELdZGXxSvHq9oaESy
	 lPqY0G3hkRpkPt+FBF9qk2Gp90oNXAwAW11w7ZNd66D2E5R+hsqpnFII9z97PSXrlhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dzr86yBZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F2606A320;
	Thu, 19 Nov 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dzr86yBZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795087234;
	b=NBtDNZHQRdvXS5/S7NeuK/A+VW00YhVtEaK32ykzJG/J+V45CDvrbhu/+GlmrZwKH9cZ
	 gOm3ofoVAd0c+woCunLIxfYA5mvFO+YYM5zYjiak5VROFuwQCbE4d7kEyZZ6s+bq4iGxB
	 HzxtVqBaufzNkDoHXcfRq0rb0ovZAhrFFfVz7tUkehBLDE/970dARLAWgj18cYv6uRLNn
	 B9nx74U/e3IflANmKrzghkiF/1cvW7ocIn818fpmxkLY5o5aM3KIuF7fTWz8N00OyDpVn
	 GpUo2Utq5hbX6/ZlhwjIAWkOhVexBO+E7Ex1sVHMAHbtmFshCbNljZxM7ySGQq+kCPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795087234;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HxTh5QEOxLCvDecXq3k9qIqzQesIJHxSTR2i+oLJhDQ=;
	b=bX3YuFZXQJMR0X/FHcRfKcXKrZb/WE7vC7wv5e3SjqJjiUHbyGn9YJ0sLPVtPWLs4jX1
	 lTAptZvbwzpnk4qhXSEhfH9GA17ja50XqhgUFIAppUeiO9Ucn8aJKPygMWlwUj+btdPVK
	 tITr4GcXkgb5ViED0lISuuZYf12pptBTzirudvlHUk3NFEShr1f2bgnRGcfaWpXOyUaNn
	 Q58EGEesPEFZRGWmm2LFnUbSI6z73yfd7qgSbjdrfSAgj95hlXldQ7vG4XWpjg/vwzNzO
	 Vly7xxxYvYt+XRIQ0O5006H7gu8yK0djVXf4WOHUs4DWYT+gbLKLdqnFm/Tw+/oLh/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1FB3E1F000C7;
	Thu, 19 Nov 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087234;
	bh=HxTh5QEOxLCvDecXq3k9qIqzQesIJHxSTR2i+oLJhDQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Dzr86yBZxKGXdVnTLIPoUEh9SccaQM3nRAzFxr7to9F6S519vrEGdF0/tUjH7r7Cr
	 9tZI3IK2EuBn27i1kH7EeK1HCZ0u9fpt/797tAlcOtVzPRoS//5dbVuK5I4UeUc5KE
	 Aoyu7bzH+zDatflBlof9xpcveZyomIKWx38gvGkzuDdikEnrWzd7tZ54iULmkE4+dH
	 WP+f7bpFyP6E59+6r49im/GLPsVgWnVVKX6SVUrXmkINAofUlrI5itoQC+u5sdk27o
	 0qvqBFVvknJ1UiZbM7Yzz7YZXxwyecIxq6EBEKWOpSkJyedXa2BMLuGqqVJgn/nIdw
	 x3nhA7rJViwjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6AC434B234;
	Thu, 19 Nov 2026 11:20:33 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 11:20:33 +0000
Subject: [PATCH] tpm: xen-tpmfront: fix use-after-free in backend_changed()
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
Message-Id: <20261119-xen-tpmfront-v1-1-bfabbbed462a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIDb/moC/yXMQQqAIBBA0avErBMaF1JdJVqYTjVBFmohRHfPa
 vkW/18QyDMFaIsLPJ0ceHMZWBZgZu0mEmyzQVZSIWIjEjkR93X0m4sCq1prqWxtlIWc7J5GTt+
 u63+HY1jIxPcB9/0AQukJC3AAAAA=
X-Change-ID: 20261119-xen-tpmfront-108aa26d8c6d
To: jgg@ziepe.ca, jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, sstabellini@kernel.org, 
 linux-integrity@vger.kernel.org, xen-devel@lists.xenproject.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795087232; l=1866;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=SeHCF57qvTjGFWZBGFq4/OdwCYQKor1OKDV0zKf38bM=;
 b=9LGNWNkQtNeORKMHA4bnA+tIT8SFxlO/+PusmyfK51AQl6KJ4CyCP1WJPlQ3nrvwC7h8yimPN
 OtFGagUC1FiBQkOBQJOxyhML/GeMEo1PWXi1jzh3R0xSmvnNzdoztCF
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

Take a temporary reference before unregistering and drop it after
xenbus_frontend_closed(). This keeps dev alive for the last access and
keeps the existing order, in which TPM operations are stopped before
the frontend is marked Closed.

Found with a static analysis tool and checked by hand.

Fixes: e2683957fb26 ("drivers/tpm: add xen tpmfront interface")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on x86_64 (W=1, no new warnings). Not run with a Xen vTPM
backend.
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




