Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753695AbeE3Wle (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 18:41:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UMe5oQ007585
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 18:41:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ja131scc0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 18:41:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 30 May 2018 23:41:32 +0100
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from
 "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Date: Wed, 30 May 2018 18:41:16 -0400
In-Reply-To: <b9b37328-2977-39fe-e3d2-822144dce6f1@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
         <15281606.YptaXzsEVL@x2>
         <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
         <3607733.4k8ofLVAdP@x2>
         <1160afb4-4184-b30c-5f67-c21536b5f7d3@linux.vnet.ibm.com>
         <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com>
         <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
         <1527717628.3534.79.camel@linux.vnet.ibm.com>
         <b9b37328-2977-39fe-e3d2-822144dce6f1@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527720076.3534.84.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-05-30 at 18:15 -0400, Stefan Berger wrote:
> On 05/30/2018 06:00 PM, Mimi Zohar wrote:
> > On Wed, 2018-05-30 at 17:49 -0400, Stefan Berger wrote:
> >> So the other choice is to only keep patches 1,2, 6, and 7, so leave most
> >> of the integrity audit messages untouched. Then only create a different
> >> format for the new AUDIT_INTEGRITY_POLICY_RULE (current 8/8) that shares
> >> (for consistency reasons) the same format with the existing integrity
> >> audit messages but also misses tty= and exe= ?
> > Another option would be for the new AUDIT_INTEGRITY_POLICY_RULE to
> > call audit_log_task_info() similar to what ima_audit_measurement()
> > does.
> 
> Right. [That would mean keep 1,2, 7 and modify 8.] Is that the best 
> solution?

Yes, I think so.  Calling audit_log_task_info() will only add the
"exe=" and "tty=" to the new AUDIT_INTEGRITY_POLICY_RULE.
