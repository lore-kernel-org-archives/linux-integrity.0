Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E9372B32
	for <linux-integrity@vger.kernel.org>; Mon,  3 Aug 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751228; cv=none; b=LklsWfzrpxGq5UDTsk7lZg8dyaMi8cjrhF4imDw3WHZG6PNTOlxrdAsHtt7JScZund7v5uHSM35e0nNXdM1rzuyTknVDCVaH96pPhg+Ue3iZi/JNp1MJgPx6pdpGODcQGWvGZxl1hJmXJvsRfvj8vkSkDg6ZnW0TwTEZnrMU9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751228; c=relaxed/simple;
	bh=VTDojHWmzDF57rWjbVsqEly30gNTipH/63rqQ0BGqjI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dKod8yYfoPK3x+bMOd5SiHEV/IpMkSBtJb6AceKPpaunUlIpjxZYt4Mr5PFrr648SMFOgNRANsYAZAOxMNYOIvCxht6jNCpvkzBt6kPY/bKsqZSpwxk/3z57xS/sN290uenh6rRhOr5t4MJipfmq3ifEMSMZnuME1dxF2E/65uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2pg6dir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2pg6dir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785751226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSbzfg+WF8irzWdRDzhVCU6AXptOY9bPmk0b+GI3hig=;
	b=F2pg6dirP1sPwUhU8JAPjGR98K4srZHMInEeEZqZ3eiNnuUIzeVolnw2xlZDdP6CC1mqEM
	l87Oo7jW1KHs8E91eGfP9+OSz7e+1uaT01AI24Q7GS/GSAoFwrJjYSe69E1QryYoP1XtWU
	H+kUD1UAErWAeD6F0J0qP/gjR392b/0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-5OgXQmzJOZ-Z3BY2OCUC2A-1; Mon,
 03 Aug 2026 06:00:19 -0400
X-MC-Unique: 5OgXQmzJOZ-Z3BY2OCUC2A-1
X-Mimecast-MFC-AGG-ID: 5OgXQmzJOZ-Z3BY2OCUC2A_1785751216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F46519560B4;
	Mon,  3 Aug 2026 10:00:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B1301800480;
	Mon,  3 Aug 2026 10:00:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
References: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev> <20260731154608.153258-1-linux@jaseg.de> <am38qk60mpVFuJRi@MiWiFi-R3L-srv> <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
To: Dave Young <ruirui.yang@linux.dev>
Cc: dhowells@redhat.com,
    =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
    Baoquan He <baoquan.he@linux.dev>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mike Rapoport <rppt@kernel.org>,
    Pasha Tatashin <pasha.tatashin@soleen.com>,
    Pratyush Yadav <pratyush@kernel.org>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    Mimi Zohar <zohar@linux.ibm.com>,
    James Bottomley <James.Bottomley@hansenpartnership.com>,
    Rob Herring <robh@kernel.org>,
    Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
    kexec@lists.infradead.org, keyrings@vger.kernel.org,
    linux-mm@kvack.org, linux-security-module@vger.kernel.org,
    linux-integrity@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2490024.1785751199.1@warthog.procyon.org.uk>
Date: Mon, 03 Aug 2026 10:59:59 +0100
Message-ID: <2490025.1785751199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Dave Young <ruirui.yang@linux.dev> wrote:

> Cleaning up secret data can be done with makedumpfile + eppic scripts (see
> the manual of makedumpfile), or it is even possible to do so in kdump kernel
> with Tao Liu's improvments for makedumpfile previously (I don't know the
> status, probably dropped for the time being, but it is possible, cced him).

Does this represent a leak of the secrets?  Also do governmental
standardisation bodies have opinions on what constitutes a leak?

David

